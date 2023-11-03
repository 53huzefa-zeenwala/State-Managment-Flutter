import 'package:about_cubit_pac/dialog/generic_dialog.dart';
import 'package:about_cubit_pac/strings.dart';
import 'package:flutter/material.dart';

typedef OnLoginTapped = void Function(
  String email,
  String password,
);

class LoginButton extends StatelessWidget {
  final OnLoginTapped onLoginTapped;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.onLoginTapped,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final email = emailController.text;
        final password = passwordController.text;

        if (email.isEmpty || password.isEmpty) {
          showGenericDialog(
            context: context,
            title: emailPasswordEmptyDialogTitle,
            content: emailOrPasswordEmptyDescription,
            optionsBuilder: () => {
              ok: true,
            },
          );
        } else {
          onLoginTapped(email, password);
        }
      },
      child: const Text(login),
    );
  }
}
