import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/constants.dart';

class FeedInput extends StatefulWidget {
  const FeedInput({super.key});

  @override
  State<FeedInput> createState() => _FeedInputState();
}

class _FeedInputState extends State<FeedInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextField(
          decoration: InputDecoration(
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
              color: AppTheme.secondaryBackgroundColor
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(EvaIcons.imageOutline),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.emoji_emotions_outlined),
                      )
                    ],
                  ),
                  Ink(
                    decoration: ShapeDecoration(
                      color: AppTheme.primaryColor,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Handle button press
                      },
                      splashRadius: 19,
                      icon: Icon(
                        EvaIcons.paperPlane,
                        color: Colors.white,
                      ),
                    ),
                  )
                ]))
      ],
    );
  }
}
