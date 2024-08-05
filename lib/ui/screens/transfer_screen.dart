import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/transaction/transaction_bloc.dart';
import '../../blocs/card/card_bloc.dart';
import '../../blocs/card/card_state.dart';
import '../../data/models/transaction_model.dart';
import '../../data/models/card_model.dart';

class TransferScreen extends StatefulWidget {
  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController fromCardController = TextEditingController();
  final TextEditingController toCardController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  CardModel? selectedFromCard;
  CardModel? selectedToCard;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    fromCardController.dispose();
    toCardController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Money'),
      ),
      body: BlocBuilder<CardBloc, CardState>(
        builder: (context, state) {
          if (state is CardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CardLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<CardModel>(
                      decoration: const InputDecoration(
                          labelText: 'From Card', border: OutlineInputBorder()),
                      items: state.cards.map((card) {
                        return DropdownMenuItem<CardModel>(
                          value: card,
                          child: Text(card.fullname),
                        );
                      }).toList(),
                      onChanged: (card) {
                        setState(() {
                          selectedFromCard = card;
                          fromCardController.text = card?.fullname ?? '';
                        });
                      },
                      value: selectedFromCard,
                      validator: (value) =>
                          value == null ? 'Please select a card' : null,
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<CardModel>(
                      decoration: const InputDecoration(
                          labelText: 'To Card', border: OutlineInputBorder()),
                      items: state.cards.map((card) {
                        return DropdownMenuItem<CardModel>(
                          value: card,
                          child: Text(card.fullname),
                        );
                      }).toList(),
                      onChanged: (card) {
                        setState(() {
                          selectedToCard = card;
                          toCardController.text = card?.fullname ?? '';
                        });
                      },
                      value: selectedToCard,
                      validator: (value) =>
                          value == null ? 'Please select a card' : null,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: amountController,
                      decoration: const InputDecoration(
                          labelText: 'Amount', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        final double? amount = double.tryParse(value);
                        if (amount == null || amount <= 0) {
                          return 'Please enter a valid amount';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
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
                            const SnackBar(
                                content: Text('Please fill all fields')),
                          );
                        }
                      },
                      child: const Text('Transfer'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Failed to load cards'));
          }
        },
      ),
    );
  }
}
