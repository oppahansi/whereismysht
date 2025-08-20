// Project Imports
import 'package:where_is_my_sht/core/db/db.dart';
import 'package:where_is_my_sht/core/models/item_transaction.dart';

class ItemTransactionRepo {
  static final ItemTransactionRepo _instance = ItemTransactionRepo._internal();
  factory ItemTransactionRepo() => _instance;
  ItemTransactionRepo._internal();

  final tableName = 'item_transaction';

  Future<List<ItemTransaction>> getActiveByType(TransactionType type) async {
    final db = await Db.getInstance();
    final maps = await db.query(
      tableName,
      where: 'type = ? AND was_returned = 0 AND was_lost = 0',
      whereArgs: [type.index],
      orderBy: 'date DESC',
    );
    return maps.map(ItemTransaction.fromMap).toList();
  }

  Future<List<ItemTransaction>> getReturnedByType(TransactionType type) async {
    final db = await Db.getInstance();
    final maps = await db.query(
      tableName,
      where: 'type = ? AND was_returned = 1 AND was_lost = 0',
      whereArgs: [type.index],
      orderBy: 'date DESC',
    );
    return maps.map(ItemTransaction.fromMap).toList();
  }

  Future<List<ItemTransaction>> getLostItems() async {
    final db = await Db.getInstance();
    final maps = await db.query(
      tableName,
      where: 'was_lost = 1',
      orderBy: 'date DESC',
    );
    return maps.map(ItemTransaction.fromMap).toList();
  }

  Future<ItemTransaction?> getTransaction(int id) async {
    final db = await Db.getInstance();
    final maps = await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return ItemTransaction.fromMap(maps.first);
    }
    return null;
  }

  Future<int> addTransaction(ItemTransaction transaction) async {
    final db = await Db.getInstance();
    return await db.insert(tableName, transaction.toMap());
  }

  Future<void> updateTransaction(ItemTransaction transaction) async {
    final db = await Db.getInstance();
    await db.update(
      tableName,
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<void> deleteTransaction(int id) async {
    final db = await Db.getInstance();
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> markClosed(int id, DateTime closedDate) async {
    final db = await Db.getInstance();
    await db.update(
      tableName,
      {'was_returned': 1, 'returned_date': closedDate.millisecondsSinceEpoch},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> markLost(int id, TransactionType beforeLostType) async {
    final db = await Db.getInstance();
    await db.update(
      tableName,
      {'was_lost': 1, 'before_lost_type': beforeLostType.index},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
