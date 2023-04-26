import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/post.dart';
import 'package:frontend/data/models/user.dart';
import 'package:frontend/data/services/api/post_service.dart';
import 'package:frontend/data/services/api/user_service.dart';
import 'package:frontend/presentation/widgets/home/post_tile.dart';
import 'package:frontend/presentation/widgets/profile/profile_card.dart';
import 'package:frontend/presentation/widgets/profile/profile_tabs.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends ConsumerStatefulWidget {
  final String userId;
  const ProfileView({super.key, required this.userId});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  final UserService userService = UserService();

  User _user = User(
    userId: '',
    studentId: '',
    emailAddress: '',
    userName: '',
    avatarUrl: '',
    microsoftId: '',
    bio: '',
    favoriteFood: '',
    favoriteMovie: '',
    major: '',
    residency: '',
    yearGroup: '',
    dateOfBirth: '',
  );
  Future<User> getUser(userId) async {
    return userService.getUser(userId);
  }

  final PostService postService = PostService();
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
    userService.getUser(widget.userId).then((u) => _user = u);
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
    List<Post> newPosts =
        await userService.getCreatedById(_page, widget.userId);
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
    List<Post> newSaves = await userService.getSavedById(_page, widget.userId);
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
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              splashRadius: 18,
              icon: Icon(
                EvaIcons.arrowBack,
                color: Colors.black,
              ),
              onPressed: () {
                context.go('/');
              },
            ),
            title: Text(
              "Profile",
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
            child: Column(
              children: [
                ProfileCard(user: _user),
                Container(
                  child: DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              TabBar(tabs: [
                                Tab(
                                  child: Text(
                                    "Posts",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Saves",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                // Tab(
                                //   child: Text(
                                //     "Likes",
                                //     style: TextStyle(color: Colors.black),
                                //   ),
                                // ),
                              ]),
                              Container(
                                width: 600,
                                height: 610,
                                child: TabBarView(children: [
                                  Container(
                                    child: CustomScrollView(
                                        controller: _postScrollController,
                                        slivers: [
                                          SliverList(
                                            delegate:
                                                SliverChildBuilderDelegate(
                                              (context, index) {
                                                if (index == _posts.length) {
                                                  return Center(
                                                    child: _isLoading
                                                        ? const CircularProgressIndicator()
                                                        : const SizedBox
                                                            .shrink(),
                                                  );
                                                }
                                                Post currentPost =
                                                    _posts[index];
                                                return PostTile(
                                                    post: currentPost);
                                              },
                                              childCount: _isLoading
                                                  ? _posts.length + 1
                                                  : _posts.length,
                                            ),
                                          ),
                                        ]),
                                  ),
                                  Container(
                                      child: CustomScrollView(
                                    controller: _saveScrollController,
                                    slivers: [
                                      SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          (context, index) {
                                            if (index == _saves.length) {
                                              return Center(
                                                child: _isLoading
                                                    ? const CircularProgressIndicator()
                                                    : const SizedBox.shrink(),
                                              );
                                            }
                                            Post currentPost = _saves[index];
                                            return PostTile(post: currentPost);
                                          },
                                          childCount: _isLoading
                                              ? _saves.length + 1
                                              : _saves.length,
                                        ),
                                      ),
                                    ],
                                  )),
                                  // Container(
                                  //   child: Text("Likes"),
                                  // )
                                ]),
                              )
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
