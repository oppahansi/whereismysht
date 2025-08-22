// Project Imports
import 'package:lendnborrow/core/models/item_transaction_image.dart';
import 'package:lendnborrow/core/db/db.dart';

class ItemTransactionImageRepo {
  static final ItemTransactionImageRepo _instance =
      ItemTransactionImageRepo._internal();
  factory ItemTransactionImageRepo() => _instance;
  ItemTransactionImageRepo._internal();

  final String tableName = 'item_transaction_image';

  Future<List<ItemTransactionImage>> getImagesForTransaction(
    int transactionId,
  ) async {
    final db = await Db.getInstance();
    final maps = await db.query(
      tableName,
      where: 'transaction_id = ?',
      whereArgs: [transactionId],
    );
    return maps.map((m) => ItemTransactionImage.fromMap(m)).toList();
  }

  Future<int> addImage(ItemTransactionImage image) async {
    final db = await Db.getInstance();
    return await db.insert(tableName, image.toMap());
  }

  Future<List<int>> addImages(List<ItemTransactionImage> images) async {
    final db = await Db.getInstance();
    final batch = db.batch();
    for (final image in images) {
      batch.insert(tableName, image.toMap());
    }
    final results = await batch.commit();
    return results.map((result) => result as int).toList();
  }

  Future<void> deleteImage(int id) async {
    final db = await Db.getInstance();
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteImagesForTransaction(int transactionId) async {
    final db = await Db.getInstance();
    await db.delete(
      tableName,
      where: 'transaction_id = ?',
      whereArgs: [transactionId],
    );
  }
}
