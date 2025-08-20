// Package Imports
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Imports
import 'package:where_is_my_sht/core/models/item_transaction.dart';
import 'package:where_is_my_sht/core/services/item_transaction_service.dart';

part 'item_transaction_provider.g.dart';

@riverpod
Future<List<ItemTransaction>> lentItems(Ref ref) async {
  final service = ItemTransactionService();
  return service.getLentItems(isClosed: false);
}

@riverpod
Future<List<ItemTransaction>> borrowedItems(Ref ref) async {
  final service = ItemTransactionService();
  return service.getBorrowedItems(isClosed: false);
}

@riverpod
Future<List<ItemTransaction>> lostItems(Ref ref) async {
  final service = ItemTransactionService();
  return service.getLostItems();
}

@riverpod
Future<List<ItemTransaction>> historyItems(Ref ref) async {
  final service = ItemTransactionService();
  final results = await Future.wait<List<ItemTransaction>>([
    service.getLentItems(isClosed: true),
    service.getBorrowedItems(isClosed: true),
    service.getLostItems(),
  ]);

  return <ItemTransaction>[...results[0], ...results[1], ...results[2]];
}
