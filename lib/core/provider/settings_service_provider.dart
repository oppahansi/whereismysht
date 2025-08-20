// Package Imports
import "package:riverpod_annotation/riverpod_annotation.dart";

// Project Imports
import "package:where_is_my_sht/core/models/settings.dart";
import "package:where_is_my_sht/core/services/settings_service.dart";

part "settings_service_provider.g.dart";

@riverpod
class SettingsServiceNotifier extends _$SettingsServiceNotifier {
  @override
  FutureOr<Settings> build() async {
    final service = SettingsService();
    await service.initSettings();

    return SettingsService.getSettings();
  }

  Future<void> setSetting(String key, String value) async {
    final service = SettingsService();
    await service.setSetting(key, value);

    state = AsyncData(SettingsService.getSettings());
  }
}
