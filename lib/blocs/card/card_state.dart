import 'package:equatable/equatable.dart';
import '../../data/models/card_model.dart';

abstract class CardState extends Equatable {
  const CardState();

  @override
  List<Object> get props => [];
}

class CardLoading extends CardState {}

class CardLoaded extends CardState {
  final List<CardModel> cards;

  const CardLoaded({this.cards = const <CardModel>[]});

  @override
  List<Object> get props => [cards];
}

class CardError extends CardState {}
