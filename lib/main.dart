import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/services/api/auth_service.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/providers/socket_provider.dart';
import 'package:frontend/router/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCTtwnhUGrGI0O7TSV6tUDtHHNgZiKdkXs",
          authDomain: "ashesinetwork.firebaseapp.com",
          projectId: "ashesinetwork",
          storageBucket: "ashesinetwork.appspot.com",
          messagingSenderId: "156517300949",
          appId: "1:156517300949:web:ad424bebb754482295405c",
          measurementId: "G-GXTBB0NNP0"));

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // throw Exception('Something went wrong refresh your page');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future(() {
      ref.watch(socketProvider).connect();
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
