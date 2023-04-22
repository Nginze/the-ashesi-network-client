import 'package:flutter/material.dart';
import 'package:frontend/data/models/comment.dart';
import 'package:frontend/data/models/post.dart';
import 'package:frontend/data/services/api/post_service.dart';
import 'package:frontend/presentation/screens/detailed_post_screen.dart';
import 'package:frontend/presentation/widgets/detailed/comment_input.dart';
import 'package:frontend/presentation/widgets/detailed/comment_tile.dart';
import 'package:frontend/presentation/widgets/detailed/detailed_tile.dart';
import 'package:frontend/presentation/widgets/home/_feed_input.dart';
import 'package:frontend/presentation/widgets/home/post_tile.dart';
import 'package:go_router/go_router.dart';

class DetailedView extends StatefulWidget {
  final String postId;

  const DetailedView({super.key, required this.postId});

  @override
  _DetailedViewState createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  final PostService postService = PostService();
  ScrollController _scrollController = ScrollController();
  List<Comment> _comments = [];
  Post _post = Post(
      postId: '',
      mediaUrl: '',
      title: '',
      content: '',
      createdAt: DateTime.now(),
      author: {},
      likeCount: 0,
      hasLiked: false,
      hasSaved: false,
      commentCount: 0);
  bool _isLoading = false;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _scrollController.addListener(_onScroll);
    postService.getPost(widget.postId).then((p) => setState(
          () {
            _post = p;
          },
        ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    List<Comment> newComments =
        await postService.getComments(_page, widget.postId);
    setState(() {
      _comments.addAll(newComments);
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
          backgroundColor: Colors.white,
          leading: IconButton(
            splashRadius: 18,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              context.go('/');
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Post",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _post.postId != ''
              ?
              Text(
                "@${_post.author['username'].replaceAll(' ', '').toLowerCase()}",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )
              : Center()
            ],
          ),
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
        _post.postId != ''
            ? SliverToBoxAdapter(
                child: PostTile(
                  post: _post,
                ),
              )
            : SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator())),
        SliverToBoxAdapter(
          child: Container(child: CommentInputInput(post: _post,)),
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
              if (index == _comments.length) {
                return Center(
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const SizedBox.shrink(),
                );
              }
              Comment currentComment = _comments[index];
              return Column(
                children: [
                  CommentTile(comment: currentComment),
                  Divider(
                    height: 0.5,
                  )
                ],
              );
            },
            childCount: _isLoading ? _comments.length + 1 : _comments.length,
          ),
        ),
      ],
    );
  }
}
