// Package Imports
import "package:sqflite/sqflite.dart";

// Project Imports
import "package:where_is_my_sht/core/db/db.dart";

class SettingsRepo {
  static final SettingsRepo _instance = SettingsRepo._internal();
  factory SettingsRepo() => _instance;
  SettingsRepo._internal();

  static const String _table = "settings";

  Future<void> setSetting(String key, String value) async {
    final db = await Db.getInstance();
    await db.insert(_table, {
      "key": key,
      "value": value,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> getSetting(String key) async {
    final db = await Db.getInstance();
    final List<Map<String, dynamic>> settings = await db.query(
      _table,
      where: "key = ?",
      whereArgs: [key],
    );
    if (settings.isNotEmpty) {
      return settings.first["value"] as String?;
    }
    return null;
  }

  Future<Map<String, String>> getAllSettings() async {
    final db = await Db.getInstance();
    final settings = await db.query(_table);
    final Map<String, String> settingsMap = {};
    for (final setting in settings) {
      settingsMap[setting["key"] as String] = setting["value"] as String;
    }
    return settingsMap;
  }
}
