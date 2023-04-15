import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/services/api/auth_service.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/utils/constants.dart';

class LoginForm extends StatefulWidget{
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 40),
        width: 500,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 100),
              const Text('Login to your account',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(
                height: 10,
              ),
              const Text('Enter the fields below to get started'),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 50,
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: Image.asset('assets/images/microsoft_icon.png',
                      width: 15),
                  label: const Text(
                    'Sign in with Microsoft',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(1),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () => {authService.loginWithMicrosoft()},
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: 0.8,
                      color: const Color.fromARGB(225, 228, 228, 228),
                    ),
                  ),
                  const Text('or'),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: 0.8,
                      color: const Color.fromARGB(225, 228, 228, 228),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                  child: SizedBox(
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelStyle: TextStyle(fontSize: 14),
                      fillColor: AppTheme.secondaryBackgroundColor,
                      labelText: 'Email address*',
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
              )),
              const SizedBox(height: 20),
              SizedBox(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: 'Password*',
                    border: OutlineInputBorder(),
                    fillColor: AppTheme.secondaryBackgroundColor,
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    child: const Text("SignUp"),
                    onPressed: () => {},
                  )
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0.0),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppTheme.primaryColor)),
                  child: const Text(
                    'Login to account',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print(_email);
                      print(_password);
                      authService.login(_email, _password);
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
