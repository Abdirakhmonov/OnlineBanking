import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/transaction_model.dart';
import '../../data/repositories/transaction_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository transactionRepository;

  TransactionBloc({required this.transactionRepository})
      : super(TransactionInitial()) {
    on<LoadTransactions>((event, emit) async {
      emit(TransactionLoading());
      try {
        final transactions =
            await transactionRepository.getTransactions().first;
        emit(TransactionLoaded(transactions));
      } catch (_) {
        emit(TransactionFailure());
      }
    });

    on<AddTransaction>((event, emit) async {
      try {
        await transactionRepository.addTransaction(event.transaction);
        final transactions =
            await transactionRepository.getTransactions().first;
        emit(TransactionLoaded(transactions));
      } catch (_) {
        emit(TransactionFailure());
      }
    });
  }
}
