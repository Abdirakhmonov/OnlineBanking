import 'package:equatable/equatable.dart';
import '../../data/models/card_model.dart';


abstract class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}

class LoadCards extends CardEvent {}

class UpdateCards extends CardEvent {
  final List<CardModel> cards;

  const UpdateCards(this.cards);

  @override
  List<Object> get props => [cards];
}

class AddCard extends CardEvent {
  final CardModel card;

  const AddCard(this.card);

  @override
  List<Object> get props => [card];
}
