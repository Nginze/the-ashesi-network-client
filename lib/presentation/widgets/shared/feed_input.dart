import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/services/api/post_service.dart';
import 'package:frontend/presentation/widgets/shared/create_modal.dart';
import 'package:frontend/utils/constants.dart';

class FeedInput extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: Column(
          children: [
            TextField(
              maxLines: 2,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(child: CustomModal());
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
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: AppTheme.secondaryBackgroundColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8))),
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
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(child: CustomModal());
                                });
                          },
                          child: const Icon(EvaIcons.imageOutline),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(child: CustomModal());
                                });
                          },
                          child: const Icon(Icons.emoji_emotions_outlined),
                        )
                      ],
                    ),
                    TextButton.icon(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(child: CustomModal());
                            });
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
        ));
  }
}