import 'package:about_cubit_pac/views/email_text_field.dart';
import 'package:about_cubit_pac/views/login_button.dart';
import 'package:about_cubit_pac/views/password_text_field.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginView extends HookWidget {
  final OnLoginTapped onLoginTapped;

  const LoginView(this.onLoginTapped, {super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Column(
      children: [
        EmailTextField(emailController: emailController),
        PasswordTextField(passwordController: passwordController),
        LoginButton(
          onLoginTapped: onLoginTapped,
          emailController: emailController,
          passwordController: passwordController,
        ),
      ],
    );
  }
}
