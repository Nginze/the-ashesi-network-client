import 'package:frontend/presentation/screens/auth_callback_screen.dart';
import 'package:frontend/presentation/screens/detailed_post_screen.dart';
import 'package:frontend/presentation/screens/home_screen.dart';
import 'package:frontend/presentation/screens/login_screen.dart';
import 'package:frontend/presentation/screens/signup_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
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
    builder: (context, state) =>  AuthCallbackScreen(),
  ),
  // GoRoute(
  //   path: '/profile/:userId',
  //   pageBuilder: (context, state) => ProfilePage(
  //     userId: state.params['userId'],
  //   ),
  // ),
  GoRoute(
    path: '/post/:postId',
    builder: (context, state) => DetailedPage(postId: state.params['postId']),
  ),
]);
