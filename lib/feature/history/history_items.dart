// Flutter Imports
import "package:flutter/material.dart";

// Package Imports
import "package:flutter_riverpod/flutter_riverpod.dart";

// Project Imports
import "package:where_is_my_sht/core/models/item_transaction.dart";
import "package:where_is_my_sht/core/provider/item_transaction_provider.dart";
import "package:where_is_my_sht/core/utils/colors.dart";
import "package:where_is_my_sht/core/utils/extensions.dart";
import "package:where_is_my_sht/core/utils/text_styles.dart";
import "package:where_is_my_sht/core/widgets/item_transaction_tile.dart";
import "package:where_is_my_sht/l10n/app_localizations.dart";

class HistoryItems extends ConsumerWidget {
  const HistoryItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyItemsProvider);

    return historyAsync.when(
      data: (items) {
        final localizations = AppLocalizations.of(context)!;

        final lent = items
            .where((i) => i.type == TransactionType.lent && !i.wasLost)
            .toList();
        final borrowed = items
            .where((i) => i.type == TransactionType.borrowed && !i.wasLost)
            .toList();
        final lost = items.where((i) => i.wasLost).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.borrowed_screen_title,
              style: bodyMedium(context).withColor(primaryColor(context)),
            ),
            _section(items: borrowed, context: context, ref: ref),
            const SizedBox(height: 8),
            Text(
              localizations.lent_screen_title,
              style: bodyMedium(context).withColor(primaryColor(context)),
            ),
            _section(items: lent, context: context, ref: ref),
            const SizedBox(height: 8),
            Text(
              localizations.lost.capitalize(),
              style: bodyMedium(context).withColor(primaryColor(context)),
            ),
            _section(items: lost, context: context, ref: ref),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text("Error: $e")),
    );
  }

  Widget _section({
    required List<ItemTransaction> items,
    required BuildContext context,
    required WidgetRef ref,
  }) {
    final localizations = AppLocalizations.of(context)!;

    if (items.isEmpty) {
      return Center(child: Text(localizations.no_items));
    }

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) =>
              ItemTransactionTile(item: items[index]),
        ),
      ],
    );
  }
}
