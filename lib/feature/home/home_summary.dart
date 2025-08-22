// Flutter Imports
import "package:flutter/material.dart";

// Package Imports
import "package:flutter_riverpod/flutter_riverpod.dart";

// Project Imports
import "package:lendnborrow/core/models/item_transaction.dart";
import "package:lendnborrow/core/provider/item_transaction_provider.dart";
import "package:lendnborrow/feature/borrowed/borrowed_screen.dart";
import "package:lendnborrow/feature/home/item_transactions_section.dart";
import "package:lendnborrow/feature/home/section_title.dart";
import "package:lendnborrow/feature/lent/lent_screen.dart";
import "package:lendnborrow/l10n/app_localizations.dart";

class HomeSummary extends ConsumerWidget {
  const HomeSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final borrowedItems = ref.watch(borrowedItemsProvider);
    final lentItems = ref.watch(lentItemsProvider);
    final historyItems = ref.watch(historyItemsProvider);
    final locatizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        SectionTitle(
          title: locatizations.borrowed_screen_title,
          path: BorrowedScreen.path,
        ),
        ItemTransactionsSection(
          items: borrowedItems,
          limit: 5,
          type: TransactionType.borrowed,
        ),
        const SizedBox(height: 8),
        SectionTitle(
          title: locatizations.lent_screen_title,
          path: LentScreen.path,
        ),
        ItemTransactionsSection(
          items: lentItems,
          limit: 5,
          type: TransactionType.lent,
        ),
        const SizedBox(height: 8),
        SectionTitle(
          title: locatizations.history_screen_title,
          path: locatizations.history_screen_title,
        ),
        ItemTransactionsSection(items: historyItems, limit: 5),
      ],
    );
  }
}
