import 'dart:typed_data';
import 'package:boxicons/boxicons.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/post.dart';
import 'package:frontend/data/services/api/post_service.dart';
import 'package:frontend/data/services/socket_service.dart';
import 'package:frontend/providers/selected_image_provider.dart';
import 'package:frontend/providers/socket_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CustomModal extends ConsumerStatefulWidget {
  @override
  _CustomModalState createState() => _CustomModalState();
}

class _CustomModalState extends ConsumerState<CustomModal> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  final postService = PostService();
  final SocketService socketService =
      SocketService(socket: IO.io('http://localhost:5000'));

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Container(
            width: 600,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                  splashRadius: 18,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Color.fromARGB(125, 158, 158, 158),
                      backgroundImage: ref.watch(userProvider).avatarUrl != null
                          ? NetworkImage(ref.watch(userProvider).avatarUrl)
                              as ImageProvider<Object>?
                          : const AssetImage(
                              'assets/images/default_profile.png'),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        flex: 9,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: _textController,
                                decoration: InputDecoration(
                                    floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                    hintText: "What's happening?",
                                    hintStyle: TextStyle(fontSize: 20),
                                    border: InputBorder.none),
                                maxLines: 8,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
                ref.watch(imageProvider).isNotEmpty
                    ? SingleChildScrollView(
                        child: Container(
                            width: 600,
                            constraints: BoxConstraints(maxHeight: 300),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.memory(
                                  ref.watch(imageProvider),
                                  fit: BoxFit.cover,
                                ))))
                    : Center(),
                Divider(color: Color.fromARGB(111, 138, 138, 138), height: 0.3),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            Uint8List? selectedImageBytes =
                                await ImagePickerWeb.getImageAsBytes();
                            ref.read(imageProvider.notifier).state =
                                (selectedImageBytes) as Uint8List;
                          },
                          child: const Icon(EvaIcons.imageOutline),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {},
                          child: const Icon(Icons.emoji_emotions_outlined),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 100,
                      child: TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          iconSize: MaterialStateProperty.all(25.0),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36),
                            ),
                          ),
                        ),
                        child: !isLoading
                            ? const Text(
                                "Post",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              )
                            : SizedBox(
                                height: 15,
                                width: 15,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))),
                        onPressed: () async {
                          Map<String, dynamic> post = {
                            'content': _textController.text,
                            'media_content': ref.watch(imageProvider),
                          };
                          //send info via socket hered
                          setState(() {
                            isLoading = true;
                          });
                          Map createdPost = await postService.createPost(post);
                          ref
                              .watch(socketProvider)
                              .emit("new_post", createdPost);

                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}
