import 'package:flutter/material.dart';
import 'package:frontend/data/models/post.dart';
import 'package:frontend/data/services/api/auth_service.dart';
import 'package:frontend/data/services/api/post_service.dart';
import 'package:frontend/data/services/api/user_service.dart';
import 'package:frontend/presentation/widgets/home/post_tile.dart';
import 'package:frontend/presentation/widgets/profile/profile_card.dart';
import 'package:frontend/presentation/widgets/profile/profile_tabs.dart';
import 'package:frontend/presentation/widgets/shared/feed_input.dart';
import 'package:frontend/presentation/widgets/shared/header.dart';
import 'package:frontend/presentation/widgets/shared/left_sidebar.dart';
import 'package:frontend/presentation/widgets/shared/right_sidebar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

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
    final authService = AuthService();
    return Flexible(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Header(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Expanded(
                  child: SizedBox(
                    height: 500,
                    child: LeftNavigationBar(),
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                    flex: 3,
                    child: Column(children: [
                      FutureBuilder(
                          future: authService.getMe(),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              return ProfileCard(user: snapshot.data);
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                      ProfileTab()
                    ])),
                const SizedBox(width: 30),
                const Expanded(
                  child: SizedBox(
                    height: 500,
                    width: double.infinity,
                    child: RightNavigationBar(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
