import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/models/post.dart';
import 'package:frontend/presentation/widgets/detailed/comment_input.dart';
import 'package:frontend/presentation/widgets/detailed/detailed_app_bar.dart';
import 'package:frontend/utils/helpers.dart';

class DetailedTile extends StatefulWidget {
  final Post post;
  const DetailedTile({Key? key, required this.post}) : super(key: key);

  @override
  State<DetailedTile> createState() => _DetailedTileState();
}

class _DetailedTileState extends State<DetailedTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DetailedAppBar(title: "Post"),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Color.fromARGB(125, 158, 158, 158),
              backgroundImage: widget.post.author['avatar_url'] != null
                  ? NetworkImage(widget.post.author['avatar_url'])
                      as ImageProvider<Object>?
                  : const AssetImage('assets/images/default_profile.png'),
            ),
            const SizedBox(width: 20),
            Column(children: [
              Container(
                  width: 650,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.author['username'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' @${widget.post.author['username'].replaceAll(' ', '').toLowerCase()}',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(" • "),
                        Text('${formatDateTime(widget.post.createdAt)}')
                      ])),
              const SizedBox(height: 10),
              Container(
                  width: 650,
                  child: Text(
                    widget.post.content,
                    style: TextStyle(fontFamily: 'FS'),
                  )),
              const SizedBox(height: 5),
              Container(
                  width: 650,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(EvaIcons.heartOutline),
                            iconSize: 18,
                            splashRadius: 18,
                          ),
                          Text("${widget.post.likeCount}")
                        ],
                      ),
                      const SizedBox(width: 18),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(EvaIcons.messageCircleOutline),
                            iconSize: 18,
                            splashRadius: 18,
                          ),
                          Text("${widget.post.commentCount}")
                        ],
                      ),
                      const SizedBox(width: 18),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(EvaIcons.bookmarkOutline),
                        iconSize: 18,
                        splashRadius: 18,
                      ),
                    ],
                  )),
            ]),
          ]),
        ),
      ],
    );
  }
}