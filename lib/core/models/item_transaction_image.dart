// Dart Imports
import 'dart:typed_data';

class ItemTransactionImage {
  final int? id;
  final int transactionId;
  final Uint8List image;

  ItemTransactionImage({
    this.id,
    required this.transactionId,
    required this.image,
  });

  factory ItemTransactionImage.fromMap(Map<String, dynamic> map) {
    return ItemTransactionImage(
      id: map['id'] as int?,
      transactionId: map['transaction_id'] as int,
      image: map['image'] as Uint8List,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'transaction_id': transactionId,
      'image': image,
    };
  }
}
