import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/transaction/transaction_bloc.dart';
import '../../data/models/transaction_model.dart';
import '../../data/models/card_model.dart';

class TransferScreen extends StatefulWidget {
  final List<CardModel> cards;

  TransferScreen({required this.cards});

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController fromCardController = TextEditingController();
  final TextEditingController toCardController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  CardModel? selectedFromCard;
  CardModel? selectedToCard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Money'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<CardModel>(
              decoration: const InputDecoration(labelText: 'From Card'),
              items: widget.cards.map((card) {
                return DropdownMenuItem(
                  value: card,
                  child: Text(card.number),
                );
              }).toList(),
              onChanged: (card) {
                setState(() {
                  selectedFromCard = card;
                  fromCardController.text = card?.id ?? '';
                });
              },
              value: selectedFromCard,
            ),
            DropdownButtonFormField<CardModel>(
              decoration: const InputDecoration(labelText: 'To Card'),
              items: widget.cards.map((card) {
                return DropdownMenuItem(
                  value: card,
                  child: Text(card.number),
                );
              }).toList(),
              onChanged: (card) {
                setState(() {
                  selectedToCard = card;
                  toCardController.text = card?.id ?? '';
                });
              },
              value: selectedToCard,
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedFromCard != null && selectedToCard != null) {
                  final transaction = TransactionModel(
                    id: DateTime.now().toString(),
                    fromCard: fromCardController.text,
                    toCard: toCardController.text,
                    amount: double.parse(amountController.text),
                  );
                  context
                      .read<TransactionBloc>()
                      .add(AddTransaction(transaction));
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select both cards')),
                  );
                }
              },
              child: const Text('Transfer'),
            ),
          ],
        ),
      ),
    );
  }
}
