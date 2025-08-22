// Dart Imports
import "dart:io";

// Flutter Imports
import "package:flutter/services.dart";

// Package Imports
import "package:path/path.dart";
import "package:sqflite/sqflite.dart";
import "package:path_provider/path_provider.dart";

// Project Imports
import "package:lendnborrow/core/utils/constants.dart";
import "package:lendnborrow/core/db/migrations.dart";

class Db {
  static const int dbVersion = 1;

  static Database? _instance;

  static Future<Database> getInstance() async {
    if (_instance != null) {
      return _instance!;
    }

    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, dbName);

    if (!await File(path).exists()) {
      ByteData data = await rootBundle.load(dbPath);
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      await File(path).writeAsBytes(bytes, flush: true);
    }

    _instance = await openDatabase(
      path,
      version: dbVersion,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      // If the file is created by sqflite (not our asset), this runs.
      onCreate: (db, version) async {
        await DbMigrations.run(db, 0, version);
      },
      // For our asset (user_version=0), this runs on first open and on upgrades.
      onUpgrade: (db, from, to) async {
        await DbMigrations.run(db, from, to);
      },
      onDowngrade: onDatabaseDowngradeDelete, // optional: wipe on downgrade
    );

    return _instance!;
  }

  static Future<Database> initializeDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, dbName);

    if (!await File(path).exists()) {
      ByteData data = await rootBundle.load(dbPath);
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      await File(path).writeAsBytes(bytes, flush: true);
    }

    return openDatabase(
      path,
      version: dbVersion,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await DbMigrations.run(db, 0, version);
      },
      onUpgrade: (db, from, to) async {
        await DbMigrations.run(db, from, to);
      },
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  /// Close the open database so the file can be safely copied or replaced.
  static Future<void> close() async {
    if (_instance != null) {
      await _instance!.close();
      _instance = null;
    }
  }

  /// Absolute path to the active database file in the app documents directory.
  static Future<String> getDbPath() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    return join(documentsDirectory.path, dbName);
  }

  /// Create a timestamped backup of the DB inside the app's documents/backups.
  /// Returns the created File.
  static Future<File> backupToAppFolder() async {
    await close();
    final srcPath = await getDbPath();
    final docs = await getApplicationDocumentsDirectory();
    final backupsDir = Directory(join(docs.path, "backups"));
    await backupsDir.create(recursive: true);

    String two(int n) => n.toString().padLeft(2, '0');
    final now = DateTime.now();
    final name =
        "lendnborrow_${now.year}${two(now.month)}${two(now.day)}_${two(now.hour)}${two(now.minute)}${two(now.second)}.db";
    final dest = File(join(backupsDir.path, name));
    return await File(srcPath).copy(dest.path);
  }

  /// Restore the DB from a file (overwrites current DB). Closes DB beforehand.
  static Future<void> restoreFromFile(File source) async {
    await close();
    final destPath = await getDbPath();
    final bytes = await source.readAsBytes();
    await File(destPath).writeAsBytes(bytes, flush: true);
  }
}
