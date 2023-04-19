import 'package:flutter/material.dart';
import 'package:frontend/data/models/comment.dart';
import 'package:frontend/data/models/post.dart';
import 'package:frontend/data/services/api/post_service.dart';
import 'package:frontend/presentation/widgets/detailed/comment_input.dart';
import 'package:frontend/presentation/widgets/detailed/comment_tile.dart';
import 'package:frontend/presentation/widgets/detailed/detailed_tile.dart';
import 'package:frontend/presentation/widgets/home/post_tile.dart';
import 'package:frontend/presentation/widgets/shared/feed_input.dart';
import 'package:frontend/presentation/widgets/shared/header.dart';
import 'package:frontend/presentation/widgets/shared/layout.dart';
import 'package:frontend/presentation/widgets/shared/left_sidebar.dart';
import 'package:frontend/presentation/widgets/shared/right_sidebar.dart';

class DetailedPage extends StatefulWidget {
  final String? postId;
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
          await postService.getComments(page, (widget.postId) as String);
      setState(() {
        comments.addAll(newPosts);
        page++;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout();
    // Future<Post> post = postService.getPost((widget.postId) as String);

    // return SafeArea(
    //     child: Scaffold(
    //   backgroundColor: Colors.white,
    //   body: Column(
    //     children: [
    //       Header(),
    //       Container(
    //         margin: const EdgeInsets.symmetric(vertical: 30),
    //         padding: const EdgeInsets.symmetric(horizontal: 50),
    //         child: Row(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             const Expanded(
    //               child: SizedBox(
    //                 height: 500,
    //                 child: LeftNavigationBar(),
    //               ),
    //             ),
    //             const SizedBox(width: 30),
    //             Expanded(
    //                 flex: 3,
    //                 child: SliverList(
    //                   delegate: SliverChildBuilderDelegate(
    //                     childCount: 25,
    //                     (context, index) {
    //                       Text("hello world");
    //                     },
    //                   ),
    //                 )
    //                 //   delegate: Column(children: [
    //                 // FutureBuilder(
    //                 //     future: post,
    //                 //     builder: (context, snapshot) {
    //                 //       return snapshot.hasData
    //                 //           ? Column(
    //                 //               crossAxisAlignment:
    //                 //                   CrossAxisAlignment.start,
    //                 //               children: [
    //                 //                 DetailedTile(
    //                 //                     post: (snapshot.data) as Post),
    //                 //                 Container(
    //                 //                     margin: EdgeInsets.fromLTRB(
    //                 //                         25, 0, 20, 25),
    //                 //                     child: CommentInput()),
    //                 //                 Text(
    //                 //                   "${snapshot.data!.commentCount} Comments",
    //                 //                   style: TextStyle(
    //                 //                       fontSize: 18,
    //                 //                       fontWeight: FontWeight.bold),
    //                 //                 ),
    //                 //               ],
    //                 //             )
    //                 //           : Center();
    //                 //     }),
    //                 // Container(
    //                 //   height: 175,
    //                 //   child: ListView.builder(
    //                 //     controller: scrollController,
    //                 //     itemCount: comments.length + 1,
    //                 //     itemBuilder: (context, index) {
    //                 //       if (index == comments.length) {
    //                 //         return Center(
    //                 //           child: isLoading
    //                 //               ? CircularProgressIndicator()
    //                 //               : SizedBox.shrink(),
    //                 //         );
    //                 //       }

    //                 //       Comment comment = comments[index];
    //                 //       return CommentTile(comment: comment);
    //                 //     },
    //                 //   ),
    //                 // ),
    //                 ),
    //             const SizedBox(width: 30),
    //             const Expanded(
    //               child: SizedBox(
    //                 height: 500,
    //                 width: double.infinity,
    //                 child: RightNavigationBar(),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // ));
  }
}
