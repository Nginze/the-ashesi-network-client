import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/services/api/auth_service.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/utils/constants.dart';
import 'package:go_router/go_router.dart';

class SignupForm extends ConsumerStatefulWidget {
  const SignupForm({super.key});

  @override
  ConsumerState<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends ConsumerState<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _studentId = '';
  String _userName = '';
  String _password = '';
  String _confirmPassword = '';

  bool isLoading = false;

  TextEditingController _idController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        width: 500,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 100),
              const Text('Create your account',
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
                  controller: _idController,
                  decoration: const InputDecoration(
                      labelStyle: TextStyle(fontSize: 14),
                      fillColor: AppTheme.secondaryBackgroundColor,
                      labelText: 'Student id*',
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
                  child: SizedBox(
                child: TextFormField(
                  controller: _emailController,
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
                  child: SizedBox(
                child: TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                      labelStyle: TextStyle(fontSize: 14),
                      fillColor: AppTheme.secondaryBackgroundColor,
                      labelText: 'Username*',
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
                  controller: _passwordController,
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
                  const Text("Already have an account?"),
                  TextButton(
                    child: const Text("Login"),
                    onPressed: () {
                      context.go('/login');
                    },
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
                  child: !isLoading
                      ? const Text(
                          'Create account',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }
                    setState(() {
                      isLoading = true;
                    });
                    final loggedInUser = await authService.signUp(
                        _emailController.text,
                        _passwordController.text,
                        _usernameController.text,
                        _idController.text);

                    setState(() {
                      isLoading = false;
                    });

                    ref.read(userProvider.notifier).state = loggedInUser;
                    context.go('/');
                  },
                ),
              )
            ],
          ),
        ));
  }
}
