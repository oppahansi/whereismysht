// Flutter Imports
import "package:flutter/material.dart";

// Project Imports
import "package:lendnborrow/core/models/settings.dart";
import "package:lendnborrow/core/repos/settings_repo.dart";
import "package:lendnborrow/core/utils/constants.dart";

class SettingsService {
  static final SettingsService _instance = SettingsService._internal();
  factory SettingsService() => _instance;
  SettingsService._internal();

  final SettingsRepo _repo = SettingsRepo();

  late ThemeMode _themeMode;
  late Locale _locale;

  static late Settings _settings;

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  Future<void> setSetting(String key, String value) async {
    await _repo.setSetting(key, value);
    _update(key, value);
  }

  Future<String?> getSetting(String key) async {
    return await _repo.getSetting(key);
  }

  Future<void> initSettings() async {
    final settingsMap = await _repo.getAllSettings();

    settingsMap.putIfAbsent(
      settingsKeyLocale,
      () => settingsValueLocaleDefault,
    );
    settingsMap.putIfAbsent(
      settingsKeyThemeMode,
      () => settingsValueThemeModeSystem,
    );

    _init(settingsMap);
  }

  void _init(Map<String, dynamic> map) {
    if (map.containsKey(settingsKeyLocale)) {
      _locale = Locale(map[settingsKeyLocale]);
    }

    if (map.containsKey(settingsKeyThemeMode)) {
      switch (map[settingsKeyThemeMode]) {
        case settingsValueThemeModeLight:
          _themeMode = ThemeMode.light;
          break;
        case settingsValueThemeModeDark:
          _themeMode = ThemeMode.dark;
          break;
        default:
          _themeMode = ThemeMode.system;
      }
    }

    _settings = Settings(themeMode: _themeMode, locale: _locale);
  }

  void _update(String key, String value) {
    switch (key) {
      case settingsKeyLocale:
        _locale = Locale(value);
        break;
      case settingsKeyThemeMode:
        switch (value) {
          case settingsValueThemeModeLight:
            _themeMode = ThemeMode.light;
            break;
          case settingsValueThemeModeDark:
            _themeMode = ThemeMode.dark;
            break;
          default:
            _themeMode = ThemeMode.system;
        }
      default:
        break;
    }

    _settings = Settings(themeMode: _themeMode, locale: _locale);
  }

  static Settings getSettings() {
    return _settings;
  }
}
