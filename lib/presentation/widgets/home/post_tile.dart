import 'dart:math';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/models/post.dart';
import 'package:frontend/data/services/api/post_service.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:go_router/go_router.dart';

class PostTile extends StatefulWidget {
  final Post post;
  const PostTile({Key? key, required this.post}) : super(key: key);

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  final postService = PostService();
  bool _liked = false;
  bool _saved = false;
  int _likes = 0;
  int _comments = 0;

  final List<Color> colors = [
    Colors.blue,
    Colors.orange,
    Colors.purple,
  ];
  final random = Random();

  @override
  void initState() {
    super.initState();
    _liked = (widget.post.hasLiked) as bool;
    _saved = (widget.post.hasSaved) as bool;
    _likes = (widget.post.likeCount) as int;
    _comments = (widget.post.commentCount) as int;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
          onTap: () {
            context.go('/post/${widget.post.postId}');
          },
          child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context
                                  .go('/profile/${widget.post.author['id']}');
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  Color.fromARGB(125, 158, 158, 158),
                              backgroundImage:
                                  widget.post.author['avatar_url'] != null
                                      ? NetworkImage(
                                              widget.post.author['avatar_url'])
                                          as ImageProvider<Object>?
                                      : const AssetImage(
                                          'assets/images/default_profile.png'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.go(
                                        '/profile/${widget.post.author['id']}');
                                  },
                                  child: Container(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                        Text(
                                          widget.post.author['username'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ' @${widget.post.author['username'].replaceAll(' ', '').toLowerCase()}',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Text(" • "),
                                        Text(
                                            '${formatDateTime(widget.post.createdAt)}')
                                      ])),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                    width: 490,
                                    child: Text(
                                      widget.post.content,
                                      // style: TextStyle(fontFamily: 'FS'),
                                      softWrap: true,
                                    )),
                                widget.post.mediaUrl != null
                                    ? Container(
                                        width: 400,
                                        constraints: BoxConstraints(
                                            minHeight: 350,
                                            minWidth: 450,
                                            maxHeight: 500),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Container(
                                              color: colors[random
                                                  .nextInt(colors.length)],
                                              child: Image.network(
                                                (widget.post.mediaUrl)
                                                    as String,
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                      )
                                    : Center(),
                                const SizedBox(height: 5),
                                Container(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (_liked) {
                                                _likes--;
                                                _liked = !_liked;
                                                postService.unLikePost(
                                                    widget.post.postId);
                                              } else {
                                                _likes++;
                                                _liked = !_liked;
                                                postService.likePost(
                                                    widget.post.postId);
                                              }
                                            });
                                          },
                                          icon: Icon(_liked
                                              ? EvaIcons.heart
                                              : EvaIcons.heartOutline),
                                          color: _liked
                                              ? Colors.pink
                                              : Colors.grey,
                                          iconSize: 18,
                                          splashRadius: 18,
                                        ),
                                        Text("${_likes}")
                                      ],
                                    ),
                                    const SizedBox(width: 18),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                              EvaIcons.messageCircleOutline),
                                          color: Colors.grey,
                                          iconSize: 18,
                                          splashRadius: 18,
                                        ),
                                        Text("${_comments}")
                                      ],
                                    ),
                                    const SizedBox(width: 18),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (_saved) {
                                            _saved = !_saved;
                                            postService
                                                .unSavePost(widget.post.postId);
                                          } else {
                                            _saved = !_saved;
                                            postService
                                                .savePost(widget.post.postId);
                                          }
                                        });
                                      },
                                      icon: Icon(_saved
                                          ? EvaIcons.bookmark
                                          : EvaIcons.bookmarkOutline),
                                      color:
                                          _saved ? Colors.amber : Colors.grey,
                                      iconSize: 18,
                                      splashRadius: 18,
                                    ),
                                  ],
                                )),
                              ])
                        ]),
                  ),
                  Divider(
                    color: Color.fromARGB(85, 158, 158, 158),
                    height: 0.2,
                  )
                ],
              ))),
    );
  }
}
