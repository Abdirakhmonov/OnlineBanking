import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_banking/blocs/auth/auth_bloc.dart';
import 'package:online_banking/blocs/card/card_bloc.dart';
import 'package:online_banking/blocs/transaction/transaction_bloc.dart';
import 'package:online_banking/data/repositories/transaction_repository.dart';
import 'package:online_banking/ui/auth/screens/splash_screen.dart';
import 'package:online_banking/ui/screens/home_screen.dart';
import 'blocs/card/card_event.dart';
import 'data/repositories/card_repository.dart';
import 'data/services/firebase_auth_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = UserAuthService();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationBloc(authService)),
        BlocProvider(
          create: (context) => CardBloc(
              cardRepository:
                  CardRepository(firestore: FirebaseFirestore.instance))
            ..add(LoadCards()),
        ),
        BlocProvider(
            create: (context) => TransactionBloc(
                transactionRepository: TransactionRepository(
                    firestore: FirebaseFirestore.instance))
              ..add(LoadTransactions()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
