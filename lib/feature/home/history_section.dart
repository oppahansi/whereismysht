// Flutter Imports
import 'package:flutter/material.dart';

// Package Imports
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project Imports
import 'package:where_is_my_sht/core/provider/item_transaction_provider.dart';
import 'package:where_is_my_sht/core/widgets/item_transaction_tile.dart';
import 'package:where_is_my_sht/l10n/app_localizations.dart';

class HistorySection extends ConsumerWidget {
  final int limit;
  const HistorySection({super.key, required this.limit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final asyncItems = ref.watch(historyItemsProvider);

    return Column(
      children: [
        asyncItems.when(
          data: (items) {
            if (items.isEmpty) {
              return Text(localizations.no_history_items);
            }
            final sorted = [...items]
              ..sort(
                (a, b) => (b.returnedDate ?? b.date).compareTo(
                  a.returnedDate ?? a.date,
                ),
              );
            final latest = sorted.take(limit).toList();

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: latest.length,
              itemBuilder: (context, index) {
                final item = latest[index];
                return ItemTransactionTile(item: item);
              },
            );
          },
          loading: () => const Padding(
            padding: EdgeInsets.all(12.0),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(child: Text("Error: $e")),
          ),
        ),
      ],
    );
  }
}
