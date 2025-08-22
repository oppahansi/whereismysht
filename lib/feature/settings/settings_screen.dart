// Flutter Imports
import "package:flutter/material.dart";

// Project Imports
import "package:lendnborrow/core/utils/colors.dart";
import "package:lendnborrow/core/utils/extensions.dart";
import "package:lendnborrow/core/utils/text_styles.dart";
import "package:lendnborrow/feature/settings/ex_import_setting.dart";
import "package:lendnborrow/feature/settings/language_setting.dart";
import "package:lendnborrow/feature/settings/theme_setting.dart";
import "package:lendnborrow/l10n/app_localizations.dart";

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String path = "/settings";

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              localizations.settings_screen_title,
              style: titleMedium(context).withColor(primaryColor(context)),
            ),
            const LanguageSetting(),
            const ThemeSetting(),
            const Divider(),
            Text(
              localizations.export_import,
              style: titleMedium(context).withColor(primaryColor(context)),
            ),
            const ExImportSetting(),
          ],
        ),
      ),
    );
  }
}
