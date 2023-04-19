// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:frontend/providers/user_provider.dart';
// import 'package:frontend/utils/constants.dart';

// class CreateModal extends ConsumerWidget {
//   const CreateModal({super.key});

// //   @override
// //   State<CreateModal> createState() => _CreateModalState();
// // }

// // class _CreateModalState extends State<CreateModal> {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return AlertDialog(
//         backgroundColor: Colors.white,
//         title: Text("Hello world"),
//         content: SizedBox(
//             width: 500,
//             height: 400,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   radius: 20,
//                   backgroundColor: Color.fromARGB(125, 158, 158, 158),
//                   backgroundImage: ref.watch(userProvider).avatarUrl != null
//                       ? NetworkImage(ref.watch(userProvider).avatarUrl)
//                           as ImageProvider<Object>?
//                       : const AssetImage('assets/images/default_profile.png'),
//                 ),
//                 Column(
//                   children: [
//                     TextField(
//                       onTap: () {
//                         print("this is the modal event");
//                       },
//                       decoration: const InputDecoration(
//                         hoverColor: Colors.transparent,
//                         hintText: 'What\'s happening?',
//                         filled: true,
//                         fillColor: AppTheme.secondaryBackgroundColor,
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide.none,
//                         ),
//                         contentPadding:
//                             EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             )));
//   }
// }

import 'dart:typed_data';

import 'package:boxicons/boxicons.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/services/api/post_service.dart';
import 'package:frontend/providers/selected_image_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:image_picker_web/image_picker_web.dart';

class CustomModal extends ConsumerStatefulWidget {
  @override
  _CustomModalState createState() => _CustomModalState();
}

class _CustomModalState extends ConsumerState<CustomModal> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  final postService = PostService();

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
                            width: 500,
                            constraints: BoxConstraints(maxHeight: 300),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Stack(fit: StackFit.expand, children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.memory(
                                    ref.watch(imageProvider),
                                    fit: BoxFit.cover,
                                  )),
                              Positioned(
                                  top: 2,
                                  right: 3,
                                  child: GestureDetector(
                                      onTap: () {
                                        ref.read(imageProvider.notifier).state =
                                            Uint8List(0);
                                      },
                                      child: InkResponse(
                                        child: Icon(
                                            color: Colors.white, Icons.close),
                                      )))
                            ])))
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
                        child: const Text(
                          "Post",
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}
