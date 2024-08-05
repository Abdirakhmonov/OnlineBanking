import 'package:bloc/bloc.dart';

import '../../data/repositories/card_repository.dart';
import 'card_event.dart';
import 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepository cardRepository;

  CardBloc({required this.cardRepository}) : super(CardLoading()) {
    on<LoadCards>((event, emit) async {
      emit(CardLoading());
      try {
        cardRepository.getCards().listen((cards) {
          add(UpdateCards(cards));
        });
      } catch (_) {
        emit(CardError());
      }
    });

    on<UpdateCards>((event, emit) {
      emit(CardLoaded(cards: event.cards));
    });

    on<AddCard>((event, emit) async {
      try {
        await cardRepository.addCard(event.card);
      } catch (_) {
        emit(CardError());
      }
    });
  }
}
