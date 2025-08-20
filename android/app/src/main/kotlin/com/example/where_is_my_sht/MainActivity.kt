package de.oppahansi.where_is_my_sht

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {
	private val CHANNEL = "app.backup"
	private var pendingResult: MethodChannel.Result? = null
	private var dbPathArg: String? = null
	private val REQ_EXPORT = 1001
	private val REQ_IMPORT = 1002

	override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
		super.configureFlutterEngine(flutterEngine)
		MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
			when (call.method) {
				"exportDb" -> {
					if (pendingResult != null) {
						result.error("BUSY", "Another operation in progress", null)
						return@setMethodCallHandler
					}
					dbPathArg = call.argument<String>("dbPath")
					val suggestedName = call.argument<String>("suggestedName") ?: "whereismysht_backup.db"
					pendingResult = result

					val intent = Intent(Intent.ACTION_CREATE_DOCUMENT).apply {
						addCategory(Intent.CATEGORY_OPENABLE)
						type = "application/octet-stream"
						putExtra(Intent.EXTRA_TITLE, suggestedName)
					}
					startActivityForResult(intent, REQ_EXPORT)
				}
				"importDb" -> {
					if (pendingResult != null) {
						result.error("BUSY", "Another operation in progress", null)
						return@setMethodCallHandler
					}
					dbPathArg = call.argument<String>("dbPath")
					pendingResult = result

					val intent = Intent(Intent.ACTION_OPEN_DOCUMENT).apply {
						addCategory(Intent.CATEGORY_OPENABLE)
						type = "*/*"
					}
					startActivityForResult(intent, REQ_IMPORT)
				}
				else -> result.notImplemented()
			}
		}
	}

	override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
		super.onActivityResult(requestCode, resultCode, data)
		val res = pendingResult ?: return
		val dbPath = dbPathArg
		pendingResult = null
		dbPathArg = null

		if (resultCode != Activity.RESULT_OK || data?.data == null) {
			res.error("CANCELLED", "User cancelled", null)
			return
		}
		val uri: Uri = data.data!!
		if (dbPath == null) {
			res.error("NO_DBPATH", "Missing dbPath", null)
			return
		}
		try {
			when (requestCode) {
				REQ_EXPORT -> {
					val src = File(dbPath)
					contentResolver.openOutputStream(uri)?.use { out ->
						src.inputStream().use { input -> input.copyTo(out) }
					} ?: throw Exception("Failed to open output stream")
					res.success(true)
				}
				REQ_IMPORT -> {
					contentResolver.openInputStream(uri)?.use { input ->
						File(dbPath).outputStream().use { out -> input.copyTo(out) }
					} ?: throw Exception("Failed to open input stream")
					res.success(true)
				}
				else -> res.error("UNKNOWN", "Unknown request", null)
			}
		} catch (e: Exception) {
			res.error("IO", e.message, null)
		}
	}
}
