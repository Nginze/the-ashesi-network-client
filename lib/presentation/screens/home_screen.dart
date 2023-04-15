import 'package:flutter/material.dart';
import 'package:frontend/data/models/post.dart';
import 'package:frontend/data/services/api/post_service.dart';
import 'package:frontend/presentation/widgets/home/post_tile.dart';
import 'package:frontend/presentation/widgets/shared/feed_input.dart';
import 'package:frontend/presentation/widgets/shared/header.dart';
import 'package:frontend/presentation/widgets/shared/left_sidebar.dart';
import 'package:frontend/presentation/widgets/shared/right_sidebar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                      FeedInput(),
                      Container(
                        height: 510,
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: posts.length + 1,
                          itemBuilder: (context, index) {
                            if (index == posts.length) {
                              return Center(
                                child: isLoading
                                    ? CircularProgressIndicator()
                                    : SizedBox.shrink(),
                              );
                            } else {
                              Post post = posts[index];
                              return PostTile(post: post);
                            }
                          },
                        ),
                      ),
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

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     PostService postService = PostService();
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Column(
//           children: [
//             Header(),
//             Container(
//                 margin: const EdgeInsets.symmetric(vertical: 30),
//                 padding: const EdgeInsets.symmetric(horizontal: 50),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     const Expanded(
//                         child: SizedBox(
//                       height: 500,
//                       child: LeftNavigationBar(),
//                     )),
//                     const SizedBox(width: 30),
//                     Expanded(
//                       flex: 3,
//                       child: Container(
//                         height: 620,
//                         child: SingleChildScrollView(
//                           child: Column(children: [
//                             FeedInput(),
//                             FutureBuilder<List<Post>>(
//                               future: postService.getFeed(0, "recent"),
//                               builder: (context, snapshot) {
//                                 if (snapshot.hasData) {
//                                   List<Post> posts = snapshot.data!;
//                                   return Column(
//                                     children: posts
//                                         .map((post) => PostTile(post: post))
//                                         .toList(),
//                                   );
//                                 } else if (snapshot.hasError) {
//                                   return Text('Error: ${snapshot.error}');
//                                 } else {
//                                   return CircularProgressIndicator();
//                                 }
//                               },
//                             )
//                           ]),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 30),
//                     const Expanded(
//                       child: SizedBox(
//                           height: 500,
//                           width: double.infinity,
//                           child: RightNavigationBar()),
//                     ),
//                   ],
//                 ))
//           ],
//         ));
//   }
// }
