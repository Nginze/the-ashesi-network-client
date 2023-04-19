import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/services/api/auth_service.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/router/app_routes.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AuthService authService = AuthService();
    final me = authService.getMe();
    me.then((u) => {
      ref.read(userProvider.notifier).state = u
    });
    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'Fira'),
      routerConfig: appRouter,
    );
  }
}
