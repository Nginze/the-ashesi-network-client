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

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/user_provider.dart';

class CustomModal extends ConsumerStatefulWidget {
  @override
  _CustomModalState createState() => _CustomModalState();
}

class _CustomModalState extends ConsumerState<CustomModal> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 600,
        height: 300,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Color.fromARGB(125, 158, 158, 158),
                  backgroundImage: ref.watch(userProvider).avatarUrl != null
                      ? NetworkImage(ref.watch(userProvider).avatarUrl)
                          as ImageProvider<Object>?
                      : const AssetImage('assets/images/default_profile.png'),
                )),
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
                                border: InputBorder.none),
                            maxLines: 11,
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
                      onPressed: () {},
                      child: const Icon(EvaIcons.imageOutline),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {},
                      child: const Icon(Icons.emoji_emotions_outlined),
                    )
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    // Handle button press
                  },
                  label: Text("Send"),
                  icon: Icon(
                    EvaIcons.paperPlane,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
