import 'package:flutter/material.dart';
import 'package:frontend/data/models/post.dart';
import 'package:frontend/data/services/api/auth_service.dart';
import 'package:frontend/data/services/api/post_service.dart';
import 'package:frontend/data/services/api/user_service.dart';
import 'package:frontend/presentation/widgets/home/post_tile.dart';
import 'package:frontend/presentation/widgets/profile/profile_card.dart';
import 'package:frontend/presentation/widgets/profile/profile_tabs.dart';
import 'package:frontend/presentation/widgets/profile/profile_view.dart';
import 'package:frontend/presentation/widgets/shared/feed_input.dart';
import 'package:frontend/presentation/widgets/shared/header.dart';
import 'package:frontend/presentation/widgets/shared/layout.dart';
import 'package:frontend/presentation/widgets/shared/left_sidebar.dart';
import 'package:frontend/presentation/widgets/shared/right_sidebar.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PostService postService = PostService();
  List<Post> posts = [];
  bool isLoading = false;
  int page = 0;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    _loadPosts();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      _loadPosts();
    }
  }

  void _loadPosts() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      List<Post> newPosts = await postService.getFeed(page, "recent");
      setState(() {
        posts.addAll(newPosts);
        page++;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        main: ProfileView(
          userId: widget.userId,
        ),
        right: RightNavigationBar());
  }
}
