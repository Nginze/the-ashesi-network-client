import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/auth/signup_form.dart';
import 'package:frontend/utils/constants.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
          child: SingleChildScrollView(
        child: SignupForm(),
      )),
    );
  }
}
