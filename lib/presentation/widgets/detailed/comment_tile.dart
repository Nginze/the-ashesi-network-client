import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/models/comment.dart';
import 'package:frontend/utils/helpers.dart';

class CommentTile extends StatefulWidget {
  final Comment comment;
  const CommentTile({Key? key, required this.comment}) : super(key: key);

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        hoverColor: Colors.transparent,
        onTap: () {
          print("clicked");
        },
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Color.fromARGB(125, 158, 158, 158),
                  backgroundImage: widget.comment.author['avatar_url'] != null
                      ? NetworkImage(widget.comment.author['avatar_url'])
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
                              widget.comment.author['username'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' @${widget.comment.author['username'].replaceAll(' ', '').toLowerCase()}',
                              style: TextStyle(fontSize: 13),
                            ),
                            Text(" • "),
                            Text('${formatDateTime(widget.comment.createdAt)}')
                          ])),
                  const SizedBox(height: 10),
                  Container(
                      width: 650,
                      child: Text(
                        widget.comment.content,
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
                              const Text("6")
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
                              const Text("5")
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
                ])
              ]),
            ),
          ],
        ));
  }
}