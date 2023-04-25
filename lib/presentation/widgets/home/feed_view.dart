import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/data/models/post.dart';
import 'package:frontend/data/services/api/post_service.dart';
import 'package:frontend/data/services/socket_service.dart';
import 'package:frontend/presentation/widgets/home/_feed_input.dart';
import 'package:frontend/presentation/widgets/home/post_tile.dart';
import 'package:frontend/presentation/widgets/shared/complete_setup.dart';
import 'package:frontend/presentation/widgets/shared/feed_input.dart';
import 'package:frontend/providers/socket_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class FeedView extends ConsumerStatefulWidget {
  @override
  _FeedViewState createState() => _FeedViewState();
}

class _FeedViewState extends ConsumerState<FeedView> {
  final PostService postService = PostService();
  // final SocketService socketService =
  //     SocketService(socket: IO.io('http://localhost:5000'));
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
    List<Post> newPosts = await postService.getFeed(_page, "recent");
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

  void _registerEventListeners() {
    ref.watch(socketProvider).connect();
    ref.watch(socketProvider).addListener('new_post', (data) {
      final json = jsonDecode(data);
      // print(json);
      Post newPost = Post.fromJson(json);
      setState(() {
        _posts.insert(0, newPost);
      });

      Fluttertoast.showToast(
          msg: "📗 New Post Received!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          webPosition: 'center',
          webBgColor: "#101110",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(ref.watch(userProvider).major);
    print(ref.watch(userProvider).dateOfBirth);
    // ref.watch(socketProvider).connect();
    if (ref.watch(userProvider).major == '') {
      print('major is null');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return WillPopScope(
                onWillPop: () async => false,
                child: Dialog(child: CompleteProfileSetup()));
          });
    }
    if (!_eventListenersRegistered) {
      _registerEventListeners();
      _eventListenersRegistered = true;
    }

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          title: Text(
            "Home",
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
        SliverToBoxAdapter(
          child: Container(child: NewFeedInput()),
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
            child: const SizedBox(height: 0),
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
              // return Text('${currentPost.content}');
              return PostTile(post: currentPost);
            },
            childCount: _isLoading ? _posts.length + 1 : _posts.length,
          ),
        ),
      ],
    );
  }

  bool _eventListenersRegistered = false;
}
