// Package Imports
import "package:riverpod_annotation/riverpod_annotation.dart";

// Project Imports
import "package:lendnborrow/core/models/settings.dart";
import "package:lendnborrow/core/services/settings_service.dart";

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
