// Flutter Imports
import "package:flutter/material.dart";

// Package Imports
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:intl/intl.dart";
import "package:material_symbols_icons/symbols.dart";

// Project Imports
import "package:lendnborrow/core/models/item_transaction.dart";
import "package:lendnborrow/core/models/item_transaction_image.dart";
import "package:lendnborrow/core/provider/item_transaction_provider.dart";
import "package:lendnborrow/core/services/item_transaction_image_service.dart";
import "package:lendnborrow/core/services/item_transaction_service.dart";
import "package:lendnborrow/core/utils/colors.dart";
import "package:lendnborrow/core/utils/extensions.dart";
import "package:lendnborrow/core/utils/text_styles.dart";
import "package:lendnborrow/core/utils/utility_methods.dart";
import "package:lendnborrow/core/widgets/edit_item_form.dart";
import "package:lendnborrow/feature/borrowed/borrowed_screen.dart";
import "package:lendnborrow/feature/history/history_screen.dart";
import "package:lendnborrow/feature/home/home_screen.dart";
import "package:lendnborrow/feature/lent/lent_screen.dart";
import "package:lendnborrow/l10n/app_localizations.dart";
import "package:lendnborrow/main_screen.dart";

class ItemTransactionTile extends ConsumerWidget {
  final ItemTransaction item;

  const ItemTransactionTile({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<ItemTransactionImage>>(
      future: ItemTransactionImageService().getImagesForTransaction(item.id!),
      builder: (context, snapshot) {
        final localizations = AppLocalizations.of(context)!;

        final images = snapshot.data ?? [];
        final titleColor = item.wasLost
            ? errorColor(context)
            : item.wasReturned
            ? Colors.green
            : secondaryColor(context);
        final personLabel = switch (item.type) {
          TransactionType.lent => localizations.lent_to,
          TransactionType.borrowed => localizations.borrowed_from,
          TransactionType.lost => localizations.lost_to,
        };
        final subtitle = Text(
          DateFormat.yMd(
            Localizations.localeOf(context).languageCode,
          ).format(item.date.toLocal()),
          style: bodySmall(
            context,
          ).withColor(secondaryColor(context).withAlpha(150)),
        );

        final dateText = DateFormat.yMd(
          Localizations.localeOf(context).languageCode,
        ).format(item.date.toLocal());

        return Card(
          color: surfaceContainerColor(context),
          child: ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            expandedAlignment: Alignment.centerLeft,
            leading: _thumbnail(images),
            title: Text(
              item.itemName,
              style: bodyMedium(context).withColor(titleColor),
            ),
            subtitle: subtitle,
            trailing: _trailingButtons(context, ref),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${personLabel.capitalize()}:",
                          style: bodySmall(context).withWeight(FontWeight.bold),
                        ),
                        Text(item.personName),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${localizations.date.capitalize()}:",
                          style: bodySmall(context).withWeight(FontWeight.bold),
                        ),
                        Text(dateText),
                      ],
                    ),
                    if (item.notes != null && item.notes!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${localizations.note.capitalize()}:",
                            style: bodySmall(
                              context,
                            ).withWeight(FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item.notes!,
                              textAlign: TextAlign.right,
                              softWrap: true,
                              maxLines: null,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (item.wasReturned && item.returnedDate != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${localizations.returned_on}:",
                            style: bodySmall(
                              context,
                            ).withWeightAndColor(FontWeight.bold, Colors.green),
                          ),
                          Text(
                            DateFormat.yMd(
                              Localizations.localeOf(context).languageCode,
                            ).format(item.returnedDate!.toLocal()),
                          ),
                        ],
                      ),
                    ] else if (item.wasLost) ...[
                      const SizedBox(height: 4),
                      Text(
                        localizations.lost.capitalize(),
                        style: bodySmall(context).withWeightAndColor(
                          FontWeight.bold,
                          errorColor(context),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (images.isNotEmpty) ...[
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8,
                  ),
                  child: SizedBox(
                    height: 110,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (context, i) => GestureDetector(
                        onTap: () => showImageModal(context, images[i].image),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(
                            images[i].image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _thumbnail(List<ItemTransactionImage> images) {
    if (images.isEmpty) {
      return SizedBox(
        height: 48,
        width: 48,
        child: Icon(
          item.type == TransactionType.lent
              ? (Symbols.upload)
              : (Symbols.download),
        ),
      );
    }
    return Image.memory(
      images.first.image,
      width: 48,
      height: 48,
      fit: BoxFit.cover,
    );
  }

  Widget _trailingButtons(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final currentTab = ref.watch(currentTabIndexProvider);
    final isHistoryTab = currentTab == getRouteIndex(HistoryScreen.path);
    final isLentTab = currentTab == getRouteIndex(LentScreen.path);
    final isBorrowedTab = currentTab == getRouteIndex(BorrowedScreen.path);
    final isHomeTab = currentTab == getRouteIndex(HomeScreen.path);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isHomeTab) Icon(Symbols.expand_more),
        if (isBorrowedTab || isLentTab)
          IconButton(
            tooltip: localizations.edit.capitalize(),
            icon: const Icon(Symbols.edit),
            onPressed: () async {
              await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                isDismissible: true,
                enableDrag: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) => Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    color: surfaceDimColor(context),
                  ),
                  child: EditItemForm(item: item),
                ),
              );
            },
          ),
        if (isBorrowedTab || isLentTab)
          IconButton(
            tooltip: localizations.mark_as_lost,
            icon: const Icon(Symbols.report),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(localizations.mark_as_lost),
                  content: Text(localizations.are_you_sure),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(false),
                      child: Text(localizations.cancel.capitalize()),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(true),
                      child: Text(localizations.ok.capitalize()),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                await ItemTransactionService().markLost(
                  id: item.id!,
                  beforeLostType: item.type,
                );
                switch (item.type) {
                  case TransactionType.lent:
                    ref.invalidate(lentItemsProvider);
                    break;
                  case TransactionType.borrowed:
                    ref.invalidate(borrowedItemsProvider);
                    break;
                  case TransactionType.lost:
                    break;
                }
                ref.invalidate(lostItemsProvider);
              }
            },
          ),
        if (isBorrowedTab || isLentTab)
          IconButton(
            tooltip: localizations.mark_as_returned,
            icon: const Icon(Symbols.assignment_turned_in),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                await ItemTransactionService().markClosed(
                  id: item.id!,
                  date: picked,
                );
                switch (item.type) {
                  case TransactionType.lent:
                    ref.invalidate(lentItemsProvider);
                    break;
                  case TransactionType.borrowed:
                    ref.invalidate(borrowedItemsProvider);
                    break;
                  case TransactionType.lost:
                    ref.invalidate(lostItemsProvider);
                    break;
                }
                ref.invalidate(historyItemsProvider);
              }
            },
          ),
        if (isHistoryTab)
          IconButton(
            tooltip: localizations.reopen,
            icon: const Icon(Symbols.restore),
            onPressed: () => _reopen(item, ref),
          ),
        if (isHistoryTab)
          IconButton(
            tooltip: localizations.delete,
            icon: const Icon(Symbols.delete),
            onPressed: () => _delete(item, context, ref),
          ),
      ],
    );
  }

  Future<void> _reopen(ItemTransaction item, WidgetRef ref) async {
    if (item.wasLost) {
      await ItemTransactionService().updateItem(
        ItemTransaction(
          id: item.id,
          itemName: item.itemName,
          personName: item.personName,
          date: item.date,
          notes: item.notes,
          type: item.beforeLostType ?? item.type,
          wasLost: false,
          beforeLostType: null,
          wasReturned: item.wasReturned,
          returnedDate: item.returnedDate,
        ),
      );

      final targetType = item.beforeLostType ?? item.type;
      switch (targetType) {
        case TransactionType.lent:
          ref.invalidate(lentItemsProvider);
          break;
        case TransactionType.borrowed:
          ref.invalidate(borrowedItemsProvider);
          break;
        case TransactionType.lost:
          break;
      }

      ref.invalidate(lostItemsProvider);
      ref.invalidate(historyItemsProvider);

      return;
    }

    // Reopen returned item back to active
    await ItemTransactionService().updateItem(
      ItemTransaction(
        id: item.id,
        itemName: item.itemName,
        personName: item.personName,
        date: item.date,
        notes: item.notes,
        type: item.type,
        wasLost: item.wasLost,
        beforeLostType: item.beforeLostType,
        wasReturned: false,
        returnedDate: null,
      ),
    );
    ref.invalidate(historyItemsProvider);

    switch (item.type) {
      case TransactionType.lent:
        ref.invalidate(lentItemsProvider);
        break;
      case TransactionType.borrowed:
        ref.invalidate(borrowedItemsProvider);
        break;
      case TransactionType.lost:
        ref.invalidate(lostItemsProvider);
        break;
    }
  }

  Future<void> _delete(
    ItemTransaction item,
    BuildContext context,
    WidgetRef ref,
  ) async {
    final localizations = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(localizations.delete.capitalize()),
        content: Text(localizations.delete_from_history(item.itemName)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(localizations.cancel.capitalize()),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(localizations.delete.capitalize()),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ItemTransactionService().deleteItem(item.id!);
      ref.invalidate(historyItemsProvider);
      if (item.wasLost) {
        ref.invalidate(lostItemsProvider);
      }
    }
  }
}
