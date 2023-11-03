import 'package:about_cubit_pac/strings.dart';
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController emailController;

  const EmailTextField({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: enterYourEmail,
      ),
    );
  }
}
