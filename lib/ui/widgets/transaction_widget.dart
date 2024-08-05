import 'package:flutter/material.dart';

import '../../data/models/transaction_model.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionModel transaction;

  TransactionWidget({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'From: ${transaction.fromCard}',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('To: ${transaction.toCard}'),
            SizedBox(height: 8.0),
            Text('Amount: \$${transaction.amount.toStringAsFixed(2)}'),
            SizedBox(height: 8.0),
            Text('Transaction ID: ${transaction.id}'),
          ],
        ),
      ),
    );
  }
}
