import 'package:about_cubit_pac/strings.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController passwordController;

  const PasswordTextField({super.key, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: enterYourPassword,
      ),
    );
  }
}
