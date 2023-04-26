import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/models/comment.dart';
import 'package:frontend/data/services/api/comment_service.dart';
import 'package:frontend/presentation/widgets/detailed/reply_modal.dart';
import 'package:frontend/utils/helpers.dart';

class ReplyTile extends StatefulWidget {
  final Comment comment;
  const ReplyTile({Key? key, required this.comment}) : super(key: key);

  @override
  State<ReplyTile> createState() => _ReplyTileState();
}

class _ReplyTileState extends State<ReplyTile> {
  bool isOpen = false;
  bool repliesLoading = false;
  List<Comment> replies = [];
  final CommentService commentService = CommentService();

  Future<void> _fetchData() async {
    setState(() {
      repliesLoading = true;
    });
    List<Comment> newComments = await commentService.getReplies(
        widget.comment.postId, widget.comment.commentId as String);
    setState(() {
      replies = newComments;
      repliesLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Color.fromARGB(125, 158, 158, 158),
              backgroundImage: widget.comment.author['avatar_url'] != null
                  ? NetworkImage(widget.comment.author['avatar_url'])
                      as ImageProvider<Object>?
                  : const AssetImage('assets/images/default_profile.png'),
            ),
            const SizedBox(width: 20),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  // width: 540,
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
                  child: Text(
                widget.comment.content,
              )),
              const SizedBox(height: 5),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 18),
                  const SizedBox(width: 18),
                  widget.comment.replyCount > 0
                      ? TextButton.icon(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10))),
                          onPressed: () {
                            setState(() {
                              isOpen = !isOpen;
                            });
                            _fetchData();
                          },
                          icon: Icon(EvaIcons.chevronDown),
                          label:
                              Text("View ${widget.comment.replyCount} replies"))
                      : Center()
                ],
              )),
            ])
          ]),
        ),
        isOpen
            ? Container(
                width: 500,
                child: repliesLoading
                    ? SizedBox(width: 30, height: 30 ,child: Center(child: CircularProgressIndicator()))
                    : ListView.builder(
                        itemCount: replies.length,
                        itemBuilder: (context, index) {
                          Comment currentComment = replies[index];
                          return ReplyTile(
                            comment: currentComment,
                          );
                        }),
              )
            : Center()
      ],
    );
  }
}
