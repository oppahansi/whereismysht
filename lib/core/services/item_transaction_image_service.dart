// Project Imports
import 'package:lendnborrow/core/models/item_transaction_image.dart';
import 'package:lendnborrow/core/repos/item_transaction_image_repo.dart';

class ItemTransactionImageService {
  static final ItemTransactionImageService _instance =
      ItemTransactionImageService._internal();
  factory ItemTransactionImageService() => _instance;
  ItemTransactionImageService._internal();

  final ItemTransactionImageRepo _repo = ItemTransactionImageRepo();

  Future<List<ItemTransactionImage>> getImagesForTransaction(
    int transactionId,
  ) {
    return _repo.getImagesForTransaction(transactionId);
  }

  Future<int> addImage(ItemTransactionImage image) {
    return _repo.addImage(image);
  }

  Future<List<int>> addImages(List<ItemTransactionImage> images) {
    return _repo.addImages(images);
  }

  Future<void> deleteImage(int id) {
    return _repo.deleteImage(id);
  }

  Future<void> deleteImagesForTransaction(int transactionId) {
    return _repo.deleteImagesForTransaction(transactionId);
  }
}
