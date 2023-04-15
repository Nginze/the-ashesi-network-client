import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/services/api/auth_service.dart';
import 'package:frontend/providers/user_provider.dart';

class AuthCallbackScreen extends ConsumerWidget {
  // const AuthCallbackScreen({super.key});

//   @override
//   State<AuthCallbackScreen> createState() => _AuthCallbackScreenState();
// }

// class _AuthCallbackScreenState extends State<AuthCallbackScreen> {
  final authService = AuthService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = authService.getMe();
    me.then((u) {
      ref.read(userProvider.notifier).state = u;
      window.close();
      window.opener!.location.href = "/";
    });
    return const Scaffold(
      body: Center(child: Text("Loading...")),
    );
  }
}
