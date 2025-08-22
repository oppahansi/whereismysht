// Project Imports
import 'package:lendnborrow/core/models/item_transaction.dart';
import 'package:lendnborrow/core/repos/item_transaction_repo.dart';

class ItemTransactionService {
  static final ItemTransactionService _instance =
      ItemTransactionService._internal();
  factory ItemTransactionService() => _instance;
  ItemTransactionService._internal();

  final ItemTransactionRepo _repo = ItemTransactionRepo();

  Future<List<ItemTransaction>> getLentItems({bool isClosed = false}) =>
      isClosed
      ? _repo.getReturnedByType(TransactionType.lent)
      : _repo.getActiveByType(TransactionType.lent);

  Future<List<ItemTransaction>> getBorrowedItems({bool isClosed = false}) =>
      isClosed
      ? _repo.getReturnedByType(TransactionType.borrowed)
      : _repo.getActiveByType(TransactionType.borrowed);

  Future<List<ItemTransaction>> getLostItems() => _repo.getLostItems();

  Future<ItemTransaction?> getItem(int id) => _repo.getTransaction(id);

  Future<int> addItem(ItemTransaction transaction) =>
      _repo.addTransaction(transaction);

  Future<void> updateItem(ItemTransaction transaction) =>
      _repo.updateTransaction(transaction);

  Future<void> deleteItem(int id) => _repo.deleteTransaction(id);

  Future<void> markClosed({required int id, required DateTime date}) =>
      _repo.markClosed(id, date);

  Future<void> markLost({
    required int id,
    required TransactionType beforeLostType,
  }) => _repo.markLost(id, beforeLostType);
}
