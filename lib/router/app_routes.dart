import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/user.dart';
import 'package:frontend/data/services/api/auth_service.dart';
import 'package:frontend/presentation/screens/auth_callback_screen.dart';
import 'package:frontend/presentation/screens/bookmarks_screen.dart';
import 'package:frontend/presentation/screens/detailed_post_screen.dart';
import 'package:frontend/presentation/screens/home_screen.dart';
import 'package:frontend/presentation/screens/login_screen.dart';
import 'package:frontend/presentation/screens/profile_screen.dart';
import 'package:frontend/presentation/screens/signup_screen.dart';
import 'package:frontend/presentation/screens/suggestion_screen.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) {
      return Consumer(
        builder: (context, ref, child) {
          return Scaffold(backgroundColor: Colors.white, body: HomePage());
        },
      );
    },
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: '/signup',
    builder: (context, state) => const SignupPage(),
  ),
  GoRoute(
    path: '/callback',
    builder: (context, state) => AuthCallbackScreen(),
  ),
  GoRoute(
      path: '/bookmarks',
      builder: (context, state) =>
          Scaffold(backgroundColor: Colors.white, body: BookmarkPage())),

  GoRoute(
      path: '/suggestions',
      builder: (context, state) =>
          Scaffold(backgroundColor: Colors.white, body: PeoplePage())),
  GoRoute(
    path: '/profile/:userId',
    builder: (context, state) => Scaffold(
      backgroundColor: Colors.white,
      body: ProfilePage(
        userId: (state.params['userId']) as String,
      ),
    ),
  ),
  GoRoute(
    path: '/post/:postId',
    builder: (context, state) => Scaffold(
        backgroundColor: Colors.white,
        body: DetailedPage(postId: state.params['postId'] as String)),
  ),

]);
