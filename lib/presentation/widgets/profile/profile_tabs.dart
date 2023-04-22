import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/models/post.dart';
import 'package:frontend/data/services/api/post_service.dart';
import 'package:frontend/data/services/api/user_service.dart';
import 'package:frontend/presentation/widgets/home/post_tile.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final PostService postService = PostService();
  final UserService userService = UserService();
  ScrollController _postScrollController = ScrollController();
  ScrollController _likeScrollController = ScrollController();
  ScrollController _saveScrollController = ScrollController();

  List<Post> _posts = [];
  List<Post> _saves = [];
  List<Post> _likes = [];
  bool _isLoading = false;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
    _fetchLiked();
    _fetchSaved();
    _postScrollController.addListener(_onScrollPosts);
    _likeScrollController.addListener(_onScrollPosts);
    _saveScrollController.addListener(_onScrollPosts);
  }

  @override
  void dispose() {
    _postScrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchPosts() async {
    setState(() {
      _isLoading = true;
    });
    List<Post> newPosts = await userService.getCreated(_page);
    setState(() {
      _posts.addAll(newPosts);
      _isLoading = false;
      _page++;
    });
  }

  Future<void> _fetchSaved() async {
    setState(() {
      _isLoading = true;
    });
    List<Post> newSaves = await userService.getSaved(_page);
    setState(() {
      _saves.addAll(newSaves);
      _isLoading = false;
      _page++;
    });
  }

  Future<void> _fetchLiked() async {
    setState(() {
      _isLoading = true;
    });
    List<Post> newLikes = await userService.getSaved(_page);
    setState(() {
      _likes.addAll(newLikes);
      _isLoading = false;
      _page++;
    });
  }

  void _onScrollPosts() {
    if (_postScrollController.position.pixels ==
        _postScrollController.position.maxScrollExtent) {
      _fetchPosts();
    }
  }

  void _onScrollSaves() {
    if (_postScrollController.position.pixels ==
        _postScrollController.position.maxScrollExtent) {
      _fetchSaved();
    }
  }

  void _onScrollLikes() {
    if (_postScrollController.position.pixels ==
        _postScrollController.position.maxScrollExtent) {
      _fetchLiked();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text("tabs");
  }
}

    // final userService = UserService();
    // return Column(children: [
    //   TabBar(
    //       onTap: (index) {
    //         setState(() {
    //           _selectedIndex = index;
    //           _handleTabSelection();
    //         });
    //       },
    //       controller: _tabController,
    //       labelColor: Colors.grey,
    //       tabs: [
    //         Tab(text: "Created", icon: Icon(EvaIcons.gridOutline)),
    //         Tab(
    //           text: "Saved",
    //           icon: Icon(EvaIcons.bookmarkOutline),
    //         ),
    //       ]),
    //   _selectedIndex == 0
    //       ? Container(
    //           height: 280,
    //           child: FutureBuilder<List<Post>>(
    //             future: userService.getCreated(0),
    //             builder: (context, snapshot) {
    //               if (snapshot.hasData) {
    //                 return ListView.builder(
    //                   controller: _postScrollController,
    //                   itemCount: snapshot.data!.length,
    //                   itemBuilder: (context, index) {
    //                     return PostTile(post: snapshot.data![index]);
    //                   },
    //                 );
    //               } else if (snapshot.hasError) {
    //                 return Text('${snapshot.error}');
    //               }
    //               return CircularProgressIndicator();
    //             },
    //           ))
    //       : Container(
    //           height: 280,
    //           child: FutureBuilder<List<Post>>(
    //             future: userService.getSaved(0),
    //             builder: (context, snapshot) {
    //               if (snapshot.hasData) {
    //                 return ListView.builder(
    //                   controller: _postScrollController,
    //                   itemCount: snapshot.data!.length,
    //                   itemBuilder: (context, index) {
    //                     return PostTile(post: snapshot.data![index]);
    //                   },
    //                 );
    //               } else if (snapshot.hasError) {
    //                 return Text('${snapshot.error}');
    //               }
    //               return CircularProgressIndicator();
    //             },
    //           )),
      // TabBarView(
      //   controller: _tabController,
      //   children: [
      // ])
    // ]);