import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/transaction_model.dart';

class TransactionRepository {
  final FirebaseFirestore firestore;

  TransactionRepository({required this.firestore});

  Future<void> addTransaction(TransactionModel transaction) {
    return firestore
        .collection('transactions')
        .doc(transaction.id)
        .set(transaction.toMap());
  }

  Stream<List<TransactionModel>> getTransactions() {
    return firestore.collection('transactions').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => TransactionModel.fromMap(doc.data()))
          .toList();
    });
  }
}
