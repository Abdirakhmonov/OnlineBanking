import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/auth/auth_event.dart';
import '../widgets/check_auth.dart';
import '../widgets/my_text_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final checkAuth = CheckAuth();

  void _register() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthenticationBloc>().add(
            RegisterUserEvent(
              email: emailController.text.trim(),
              username: usernameController.text.trim(),
              password: passwordController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Create Account",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF1F41BB)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Create an account so you can explore all the existing jobs",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  MyTextField(
                      hintText: "Username",
                      controller: usernameController,
                      validator: (value) {
                        return checkAuth.validateUsername(value);
                      }),
                  const SizedBox(height: 20),
                  MyTextField(
                      hintText: "Email",
                      controller: emailController,
                      validator: (value) {
                        return checkAuth.validateEmail(value);
                      }),
                  const SizedBox(height: 20),
                  MyTextField(
                      hintText: "Password",
                      controller: passwordController,
                      validator: (value) {
                        return checkAuth.validatePassword(value);
                      }),
                  const SizedBox(height: 30),
                  MyTextField(
                      hintText: "Confirm Password",
                      controller: confirmPasswordController,
                      validator: (value) {
                        return checkAuth.validateConfirmPassword(
                            value, passwordController.text);
                      }),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _register,
                    child: Material(
                      elevation: 4, // Add elevation here
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xff1F41BB)),
                        child: const Center(
                            child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Already have an account",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
