// Flutter Imports
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

// Project Imports
import "package:lendnborrow/core/utils/colors.dart";
import "package:lendnborrow/core/utils/text_styles.dart";
import "package:lendnborrow/core/widgets/debug_settings_controlls.dart";
import "package:lendnborrow/feature/history/history_items.dart";
import "package:lendnborrow/l10n/app_localizations.dart";
import "package:lendnborrow/core/utils/extensions.dart";

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static const String path = "/history";

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (kDebugMode) DebugSettingsControlls(),
            Text(
              localizations.history_screen_title,
              style: titleMedium(context).withColor(primaryColor(context)),
            ),
            const HistoryItems(),
          ],
        ),
      ),
    );
  }
}
