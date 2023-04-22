import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/services/api/auth_service.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/router/app_routes.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // throw Exception('Something went wrong refresh your page');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future(() {
      ref.read(userLoadingProvider.notifier).state = true;
    });
    AuthService authService = AuthService();
    final me = authService.getMe();
    me.then((u) {
      ref.read(userProvider.notifier).state = u;
      ref.read(userLoadingProvider.notifier).state = false;
    });

    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'Chirp'),
      routerConfig: appRouter,
    );
  }
}
