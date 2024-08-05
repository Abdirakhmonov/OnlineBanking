import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/card_model.dart';

class CardRepository {
  final FirebaseFirestore firestore;

  CardRepository({required this.firestore});

  Future<void> addCard(CardModel card) {
    return firestore.collection('cards').doc(card.id).set(card.toMap());
  }

  Stream<List<CardModel>> getCards() {
    return firestore.collection('cards').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => CardModel.fromMap(doc.data())).toList();
    });
  }
}
