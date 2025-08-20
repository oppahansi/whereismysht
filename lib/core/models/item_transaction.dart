enum TransactionType { lent, borrowed, lost }

class ItemTransaction {
  final int? id;
  final String itemName;
  final String personName;
  final DateTime date;
  final String? notes;
  final TransactionType type;
  final bool wasLost;
  final TransactionType? beforeLostType;
  final bool wasReturned;
  final DateTime? returnedDate;

  ItemTransaction({
    this.id,
    required this.itemName,
    required this.personName,
    required this.date,
    this.notes,
    required this.type,
    this.wasLost = false,
    this.beforeLostType,
    this.wasReturned = false,
    this.returnedDate,
  });

  factory ItemTransaction.fromMap(Map<String, dynamic> map) {
    return ItemTransaction(
      id: map['id'] as int?,
      itemName: map['item_name'] as String,
      personName: map['person_name'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      notes: map['notes'] as String?,
      type: TransactionType.values[map['type'] as int],
      wasLost: (map['was_lost'] as int?) == 1,
      beforeLostType: (map['before_lost_type'] as int?) != null
          ? TransactionType.values[map['before_lost_type'] as int]
          : null,
      wasReturned: (map['was_returned'] as int?) == 1,
      returnedDate: (map['returned_date'] as int?) != null
          ? DateTime.fromMillisecondsSinceEpoch(map['returned_date'] as int)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'item_name': itemName,
      'person_name': personName,
      'date': date.millisecondsSinceEpoch,
      'notes': notes,
      'type': type.index,
      'was_lost': wasLost ? 1 : 0,
      'before_lost_type': beforeLostType?.index,
      'was_returned': wasReturned ? 1 : 0,
      'returned_date': returnedDate?.millisecondsSinceEpoch,
    };
  }
}
