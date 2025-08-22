// Flutter Imports
import 'package:flutter/material.dart';

// Package Imports
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project Imports
import 'package:lendnborrow/core/models/item_transaction.dart';
import 'package:lendnborrow/core/widgets/item_transaction_tile.dart';
import 'package:lendnborrow/l10n/app_localizations.dart';

class ItemTransactionsSection extends StatelessWidget {
  final AsyncValue<List<ItemTransaction>> items;
  final int limit;
  final TransactionType? type;

  const ItemTransactionsSection({
    super.key,
    required this.items,
    required this.limit,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return items.when(
      data: (items) {
        if (items.isEmpty) {
          final emptyText = switch (type) {
            TransactionType.lent => localizations.no_lent_items,
            TransactionType.borrowed => localizations.no_borrowed_items,
            _ => localizations.no_history_items,
          };
          return Text(emptyText);
        }
        final latest = [...items]..sort((a, b) => b.date.compareTo(a.date));
        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: latest.take(limit).length,
              itemBuilder: (context, index) {
                final item = latest[index];
                return ItemTransactionTile(item: item);
              },
            ),
          ],
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text("Error: $e")),
    );
  }
}
