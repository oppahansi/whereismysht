// Flutter Imports
import "package:flutter/material.dart";

// Package Imports
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:material_symbols_icons/symbols.dart";

// Project Imports
import "package:where_is_my_sht/core/provider/settings_service_provider.dart";
import "package:where_is_my_sht/core/utils/colors.dart";
import "package:where_is_my_sht/core/utils/constants.dart";

// Project Imports

class DebugSettingsControlls extends ConsumerWidget {
  const DebugSettingsControlls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsServiceNotifierProvider);

    return Card(
      margin: const EdgeInsets.all(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Theme
            Switch(
              thumbIcon: WidgetStateProperty.all(
                (settings.value?.themeMode == ThemeMode.dark)
                    ? Icon(Symbols.dark_mode, color: primaryColor(context))
                    : Icon(Symbols.light_mode, color: secondaryColor(context)),
              ),
              value: settings.value?.themeMode == ThemeMode.dark,
              onChanged: (isDark) {
                ref
                    .read(settingsServiceNotifierProvider.notifier)
                    .setSetting(
                      settingsKeyThemeMode,
                      isDark
                          ? settingsValueThemeModeDark
                          : settingsValueThemeModeLight,
                    );
              },
            ),
            const SizedBox(width: 4),
            // Language
            DropdownButton<String>(
              value: settings.value?.locale.languageCode,
              underline: const SizedBox(),
              icon: const Icon(Symbols.language, size: 18),
              style: Theme.of(context).textTheme.bodyMedium,
              onChanged: (String? code) {
                if (code != null) {
                  ref
                      .read(settingsServiceNotifierProvider.notifier)
                      .setSetting(settingsKeyLocale, code);
                }
              },
              items: const [
                DropdownMenuItem(value: "en", child: Text("EN")),
                DropdownMenuItem(value: "de", child: Text("DE")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
