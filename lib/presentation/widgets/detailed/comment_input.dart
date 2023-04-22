import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/models/post.dart';
import 'package:frontend/presentation/widgets/detailed/comment_modal.dart';
import 'package:frontend/presentation/widgets/shared/create_modal.dart';

class CommentInputInput extends StatefulWidget {
  final Post post;
  const CommentInputInput({super.key, required this.post});

  @override
  State<CommentInputInput> createState() => _CommentInputInputState();
}

class _CommentInputInputState extends State<CommentInputInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          child: const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
              backgroundImage: AssetImage('assets/images/default_profile.png')),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: TextField(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: CommentModal(
                                  widget.post.author['username'],
                                  widget.post.postId));
                        });
                  },
                  maxLines: 2,
                  decoration: InputDecoration(
                      hintText: "Share your thoughts",
                      border: InputBorder.none),
                ),
              ),
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                        ),
                                        child: CommentModal(
                                            widget.post.author['username'],
                                            widget.post.postId));
                                  });
                            },
                            splashRadius: 18,
                            color: Colors.blue,
                            icon: const Icon(Boxicons.bx_image),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                        ),
                                        child: CommentModal(
                                            widget.post.author['username'],
                                            widget.post.postId));
                                  });
                            },
                            splashRadius: 18,
                            color: Colors.blue,
                            icon: const Icon(Icons.emoji_emotions_outlined),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 100,
                        child: TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 25)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                            iconSize: MaterialStateProperty.all(25.0),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Reply",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
