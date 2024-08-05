import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../screens/home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadNextPage();
  }

  void _loadNextPage() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return HomeScreen();
                  } else {
                    return const LoginScreen();
                  }
                },
              );
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.bounceIn;
              dynamic tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              dynamic offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              "Online Banking",
              textStyle: const TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),
              colors: [
                Colors.blue,
                Colors.purple,
                Colors.red,
                Colors.yellow,
                Colors.blue,
              ],
            ),
          ],
          isRepeatingAnimation: true,
        ),
      ),
    );
  }
}
