import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/data/models/post.dart';
import 'package:frontend/data/services/api/post_service.dart';
import 'package:frontend/data/services/api/user_service.dart';
import 'package:frontend/data/services/socket_service.dart';
import 'package:frontend/presentation/widgets/home/_feed_input.dart';
import 'package:frontend/presentation/widgets/home/post_tile.dart';
import 'package:frontend/presentation/widgets/shared/feed_input.dart';
import 'package:frontend/providers/socket_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class BookmarkView extends ConsumerStatefulWidget {
  @override
  _BookmarkViewState createState() => _BookmarkViewState();
}

class _BookmarkViewState extends ConsumerState<BookmarkView> {
  final UserService userService = UserService();
  ScrollController _scrollController = ScrollController();
  List<Post> _posts = [];
  bool _isLoading = false;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    List<Post> newPosts = await userService.getSaved(_page);
    setState(() {
      _posts.addAll(newPosts);
      _isLoading = false;
      _page++;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          title: Text(
            "Bookmarks",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          floating: true,
        ),
        SliverToBoxAdapter(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(150, 158, 158, 158),
                  width: 0.5,
                ),
              ),
            ),
            child: const SizedBox(height: 20),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index == _posts.length) {
                return Center(
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const SizedBox.shrink(),
                );
              }
              Post currentPost = _posts[index];
              return PostTile(post: currentPost);
            },
            childCount: _isLoading ? _posts.length + 1 : _posts.length,
          ),
        ),
      ],
    );
  }

}
