// Flutter Imports
import "package:flutter/material.dart";

// Package Imports
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:material_symbols_icons/symbols.dart";

// Project Imports
import "package:lendnborrow/core/provider/settings_service_provider.dart";
import "package:lendnborrow/core/utils/constants.dart";
import "package:lendnborrow/core/utils/extensions.dart";
import "package:lendnborrow/l10n/app_localizations.dart";

class ThemeSetting extends ConsumerWidget {
  const ThemeSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsServiceNotifierProvider);
    final localizations = AppLocalizations.of(context)!;

    final themeNames = <String, String>{
      settingsValueThemeModeSystem: localizations.system.capitalize(),
      settingsValueThemeModeLight: localizations.light.capitalize(),
      settingsValueThemeModeDark: localizations.dark.capitalize(),
    };

    return settingsAsync.when(
      data: (settings) {
        String currentThemeKey;
        switch (settings.themeMode) {
          case ThemeMode.light:
            currentThemeKey = settingsValueThemeModeLight;
            break;
          case ThemeMode.dark:
            currentThemeKey = settingsValueThemeModeDark;
            break;
          default:
            currentThemeKey = settingsValueThemeModeSystem;
        }

        return ListTile(
          leading: const Icon(Symbols.brightness_6),
          title: Text(localizations.theme.capitalize()),
          subtitle: Text(themeNames[currentThemeKey] ?? currentThemeKey),
          trailing: const Icon(Symbols.chevron_right),
          onTap: () async {
            final selected = await showModalBottomSheet<String>(
              context: context,
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final themeKey in [
                    settingsValueThemeModeSystem,
                    settingsValueThemeModeLight,
                    settingsValueThemeModeDark,
                  ])
                    ListTile(
                      leading: Icon(
                        themeKey == currentThemeKey
                            ? Symbols.radio_button_checked
                            : Symbols.radio_button_unchecked,
                      ),
                      title: Text(themeNames[themeKey] ?? themeKey),
                      onTap: () => Navigator.pop(context, themeKey),
                    ),
                ],
              ),
            );
            if (selected != null && selected != currentThemeKey) {
              await ref
                  .read(settingsServiceNotifierProvider.notifier)
                  .setSetting(settingsKeyThemeMode, selected);
            }
          },
        );
      },
      loading: () => ListTile(
        leading: const Icon(Symbols.brightness_6),
        title: Text(localizations.theme),
        subtitle: Text("${localizations.loading}..."),
      ),
      error: (e, st) => ListTile(
        leading: const Icon(Symbols.brightness_6),
        title: Text(localizations.theme),
        subtitle: Text("Error: $e"),
      ),
    );
  }
}
