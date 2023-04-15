import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/presentation/widgets/shared/create_modal.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/utils/constants.dart';

class CommentInput extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 10,
              backgroundColor: Color.fromARGB(125, 158, 158, 158),
              backgroundImage: ref.watch(userProvider).avatarUrl != null
                  ? NetworkImage(ref.watch(userProvider).avatarUrl)
                      as ImageProvider<Object>?
                  : const AssetImage('assets/images/default_profile.png'),
            ),
            SizedBox(
              width: 10,
            ),
            Text('commenting as '),
            Text(ref.watch(userProvider).userName,
                style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          maxLines: 2,
          // onTap: () {
          //   showDialog(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return Dialog(
          //           child: CustomModal());
          //     },
          //   );
          // },
          decoration: const InputDecoration(
            hoverColor: Colors.transparent,
            hintText: 'Share your thoughts',
            filled: true,
            fillColor: AppTheme.secondaryBackgroundColor,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.secondaryBackgroundColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                  label: Text("Comment"),
                  icon: Icon(
                    EvaIcons.paperPlane,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
