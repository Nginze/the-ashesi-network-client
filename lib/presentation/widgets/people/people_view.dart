import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/data/models/post.dart';
import 'package:frontend/data/models/user.dart';
import 'package:frontend/data/services/api/post_service.dart';
import 'package:frontend/data/services/api/user_service.dart';
import 'package:frontend/data/services/socket_service.dart';
import 'package:frontend/presentation/widgets/home/_feed_input.dart';
import 'package:frontend/presentation/widgets/home/post_tile.dart';
import 'package:frontend/presentation/widgets/shared/feed_input.dart';
import 'package:frontend/presentation/widgets/shared/suggested_tile.dart';
import 'package:frontend/providers/socket_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class PeopleView extends ConsumerStatefulWidget {
  @override
  _PeopleViewState createState() => _PeopleViewState();
}

class _PeopleViewState extends ConsumerState<PeopleView> {
  final UserService userService = UserService();
  // final SocketService socketService =
  //     SocketService(socket: IO.io('http://localhost:5000'));
  ScrollController _scrollController = ScrollController();
  List<dynamic> suggestions = [];
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

    List<dynamic> newSuggestions = await userService.getSuggested();
    print(newSuggestions);
    setState(() {
      suggestions.addAll(newSuggestions);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchData();
    }
  }

  // void _registerEventListeners() {
  //   ref.watch(socketProvider).addListener('new_post', (data) {
  //     final json = jsonDecode(data);
  //     // print(json);
  //     Post newPost = Post.fromJson(json);
  //     setState(() {
  //       _posts.insert(0, newPost);
  //     });

  //     Fluttertoast.showToast(
  //         msg: "📗 New Post Received!",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         webPosition: 'center',
  //         webBgColor: "#101110",
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // if (!_eventListenersRegistered) {
    //   _registerEventListeners();
    //   _eventListenersRegistered = true;
    // }

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          title: Text(
            "Suggested",
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
        // SliverToBoxAdapter(
        //   child: Container(child: NewFeedInput()),
        // ),
        // SliverToBoxAdapter(
        //   child: Container(
        //     decoration: const BoxDecoration(
        //       border: Border(
        //         bottom: BorderSide(
        //           color: Color.fromARGB(150, 158, 158, 158),
        //           width: 0.5,
        //         ),
        //       ),
        //     ),
        //     child: const SizedBox(height: 0),
        //   ),
        // ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index == suggestions.length) {
                return Center(
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const SizedBox.shrink(),
                );
              }
              Map sugg = suggestions[index];
              return SuggestedTile( suggestion: sugg);
            },
            childCount: _isLoading ? suggestions.length + 1 : suggestions.length,
          ),
        ),
      ],
    );
  }

  // bool _eventListenersRegistered = false;
}