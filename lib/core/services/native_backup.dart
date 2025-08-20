// Flutter Imports
// Dart side helper for native export/import pickers via MethodChannel.
// No third-party packages; platform code uses Android SAF and iOS UIDocumentPicker.
import 'package:flutter/services.dart';

// Project Imports
import 'package:where_is_my_sht/core/db/db.dart';

class NativeBackup {
  static const MethodChannel _ch = MethodChannel('app.backup');

  /// Opens system save dialog and writes the DB to the chosen location.
  /// Returns true if the operation succeeded.
  static Future<bool> exportWithPicker() async {
    final dbPath = await Db.getDbPath();
    await Db.close();
    final ok = await _ch.invokeMethod<bool>('exportDb', {
      'dbPath': dbPath,
      'suggestedName': 'whereismysht_backup.db',
    });
    return ok == true;
  }

  /// Opens system open dialog, reads chosen file, and overwrites the DB.
  /// Returns true if the operation succeeded.
  static Future<bool> importWithPicker() async {
    final dbPath = await Db.getDbPath();
    await Db.close();
    final ok = await _ch.invokeMethod<bool>('importDb', {'dbPath': dbPath});
    return ok == true;
  }
}
