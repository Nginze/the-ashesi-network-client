import 'dart:html';

import 'package:flutter/material.dart';
import 'package:frontend/data/services/api/auth_service.dart';

class AuthCallbackScreen extends StatefulWidget {
  const AuthCallbackScreen({super.key});

  @override
  State<AuthCallbackScreen> createState() => _AuthCallbackScreenState();
}

class _AuthCallbackScreenState extends State<AuthCallbackScreen> {
  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final me = authService.getMe();
    me.then((u) {
      if (window.opener != null) {
        window.close();
        window.opener!.location.href = "/";
      }
    });
    return const Scaffold(
      body: Center(child: Text("Loading...")),
    );
  }
}
