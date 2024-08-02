class TransactionModel {
  final String id;
  final String fromCard;
  final String toCard;
  final double amount;

  TransactionModel({
    required this.id,
    required this.fromCard,
    required this.toCard,
    required this.amount,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      fromCard: map['fromCard'],
      toCard: map['toCard'],
      amount: map['amount'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fromCard': fromCard,
      'toCard': toCard,
      'amount': amount,
    };
  }
}
