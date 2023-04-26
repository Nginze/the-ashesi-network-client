import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/post.dart';
import 'package:frontend/data/services/api/post_service.dart';
import 'package:frontend/presentation/widgets/home/feed_view.dart';
import 'package:frontend/presentation/widgets/home/post_tile.dart';
import 'package:frontend/presentation/widgets/shared/feed_input.dart';
import 'package:frontend/presentation/widgets/shared/header.dart';
import 'package:frontend/presentation/widgets/shared/layout.dart';
import 'package:frontend/presentation/widgets/shared/left_sidebar.dart';
import 'package:frontend/presentation/widgets/shared/right_sidebar.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(userProvider).userId == '') {
      if (ref.watch(userLoadingProvider)) {
        return Scaffold(
          body: Container(
            child: Center(child: Image.asset("assets/images/logo-text.png", width: 120,)),
          ),
        );
      } else {
        context.go('/login');
      }
    }
    return Layout(main: FeedView(), right: RightNavigationBar());
  }
}

