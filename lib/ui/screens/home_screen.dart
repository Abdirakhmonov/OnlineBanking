import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_banking/ui/screens/transfer_history_screen.dart';

import '../../blocs/card/card_bloc.dart';
import '../../blocs/card/card_event.dart';
import '../../blocs/card/card_state.dart';
import '../../data/models/card_model.dart';
import '../widgets/card_widget.dart';
import 'transfer_screen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Banking'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Add Card'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: fullnameController,
                          decoration:
                              const InputDecoration(labelText: 'Full Name'),
                        ),
                        TextField(
                          controller: numberController,
                          decoration:
                              const InputDecoration(labelText: 'Number'),
                        ),
                        TextField(
                          controller: expiryDateController,
                          decoration:
                              const InputDecoration(labelText: 'Expiry Date'),
                        ),
                        TextField(
                          controller: balanceController,
                          decoration:
                              const InputDecoration(labelText: 'Balance'),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          final card = CardModel(
                            id: DateTime.now().toString(),
                            fullname: fullnameController.text,
                            number: numberController.text,
                            expiryDate: expiryDateController.text,
                            balance: double.parse(balanceController.text),
                          );
                          context.read<CardBloc>().add(AddCard(card));
                          Navigator.of(context).pop();
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      TransferScreen(cards: []), // Replace with actual cards
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TransactionHistoryScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CardBloc, CardState>(
        builder: (context, state) {
          if (state is CardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CardLoaded) {
            return ListView.builder(
              itemCount: state.cards.length,
              itemBuilder: (context, index) {
                final card = state.cards[index];
                return CardWidget(card: card);
              },
            );
          } else {
            return const Center(child: Text('Failed to load cards'));
          }
        },
      ),
    );
  }
}
