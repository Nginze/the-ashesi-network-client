import 'package:flutter/material.dart';
import 'package:frontend/data/models/comment.dart';
import 'package:frontend/data/models/post.dart';
import 'package:frontend/data/services/api/post_service.dart';
import 'package:frontend/presentation/widgets/detailed/comment_input.dart';
import 'package:frontend/presentation/widgets/detailed/comment_tile.dart';
import 'package:frontend/presentation/widgets/detailed/detailed_tile.dart';
import 'package:frontend/presentation/widgets/detailed/detailed_view.dart';
import 'package:frontend/presentation/widgets/home/feed_view.dart';
import 'package:frontend/presentation/widgets/home/post_tile.dart';
import 'package:frontend/presentation/widgets/shared/feed_input.dart';
import 'package:frontend/presentation/widgets/shared/header.dart';
import 'package:frontend/presentation/widgets/shared/layout.dart';
import 'package:frontend/presentation/widgets/shared/left_sidebar.dart';
import 'package:frontend/presentation/widgets/shared/right_sidebar.dart';

class DetailedPage extends StatefulWidget {
  final String postId;
  const DetailedPage({Key? key, required this.postId}) : super(key: key);

  @override
  State<DetailedPage> createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {
  PostService postService = PostService();
  List<Comment> comments = [];
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
      List<Comment> newPosts =
          await postService.getComments(page, widget.postId);
      setState(() {
        comments.addAll(newPosts);
        page++;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      main: DetailedView(postId: (widget.postId) as String),
      right: RightNavigationBar(),
    );
  }
}
