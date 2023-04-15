import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/presentation/widgets/shared/create_modal.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/utils/constants.dart';

class FeedInput extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        TextField(
          maxLines: 2,
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                    child: CustomModal());
              },
            );
          },
          decoration: const InputDecoration(
            hoverColor: Colors.transparent,
            hintText: 'What\'s happening?',
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
            ),
          ),
        )
      ],
    );
  }
}
// class _FeedInputState extends State<FeedInput> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const TextField(
//           decoration: InputDecoration(
//             hoverColor: Colors.transparent,
//             hintText: 'What\'s happening?',
//             filled: true,
//             fillColor: AppTheme.secondaryBackgroundColor,
//             border: OutlineInputBorder(
//               borderSide: BorderSide.none,
//             ),
//             contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//           ),
//         ),
//         Container(
//             decoration: BoxDecoration(
//               color: AppTheme.secondaryBackgroundColor
//             ),
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         onPressed: () {},
//                         icon: const Icon(EvaIcons.imageOutline),
//                       ),
//                       const SizedBox(width: 10),
//                       IconButton(
//                         onPressed: () {},
//                         icon: const Icon(Icons.emoji_emotions_outlined),
//                       )
//                     ],
//                   ),
//                   Ink(
//                     decoration: ShapeDecoration(
//                       color: AppTheme.primaryColor,
//                       shape: CircleBorder(),
//                     ),
//                     child: IconButton(
//                       onPressed: () {
//                         // Handle button press
//                       },
//                       splashRadius: 19,
//                       icon: Icon(
//                         EvaIcons.paperPlane,
//                         color: Colors.white,
//                       ),
//                     ),
//                   )
//                 ]))
//       ],
//     );
//   }
// }
