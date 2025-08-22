// Flutter Imports
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

// Project Imports
import "package:lendnborrow/core/models/item_transaction.dart";
import "package:lendnborrow/core/utils/colors.dart";
import "package:lendnborrow/core/utils/extensions.dart";
import "package:lendnborrow/core/utils/text_styles.dart";
import "package:lendnborrow/core/widgets/debug_settings_controlls.dart";
import "package:lendnborrow/core/widgets/item_transactions_list.dart";
import "package:lendnborrow/l10n/app_localizations.dart";

// Project Imports

class LentScreen extends StatelessWidget {
  const LentScreen({super.key});

  static const String path = "/lent";

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
              localizations.lent_screen_title,
              style: titleMedium(context).withColor(primaryColor(context)),
            ),
            const ItemTransactionsList(type: TransactionType.lent),
          ],
        ),
      ),
    );
  }
}
