// lib/models/card_model.dart
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
      id: map['id'],
      fullname: map['fullname'],
      number: map['number'],
      expiryDate: map['expiryDate'],
      balance: map['balance'],
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
