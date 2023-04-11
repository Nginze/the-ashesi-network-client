import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/auth/login_form.dart';
import 'package:frontend/utils/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
          child: SingleChildScrollView(
        child: LoginForm(),
      )),
    );
  }
}
