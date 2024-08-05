class CardModel {
  final String id;
  final String fullname;
  final String number;
  final String expiryDate;
  final double balance;

  CardModel({
    required this.id,
    required this.fullname,
    required this.number,
    required this.expiryDate,
    required this.balance,
  });

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'] ?? '',
      fullname: map['fullname'] ?? '',
      number: map['number'] ?? '',
      expiryDate: map['expiryDate'] ?? '',
      balance:
          map['balance'] != null ? (map['balance'] as num).toDouble() : 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': fullname,
      'number': number,
      'expiryDate': expiryDate,
      'balance': balance,
    };
  }
}
