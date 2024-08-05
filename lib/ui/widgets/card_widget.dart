import 'package:flutter/material.dart';

import '../../data/models/card_model.dart';

class CardWidget extends StatelessWidget {
  final CardModel card;

  CardWidget({required this.card});

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
              card.fullname,
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              card.number,
              style: const TextStyle(fontSize: 16.0, letterSpacing: 2.0),
            ),
            const SizedBox(height: 8.0),
            Text('Expiry Date: ${card.expiryDate}'),
            const SizedBox(height: 8.0),
            Text('Balance: \$${card.balance.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
