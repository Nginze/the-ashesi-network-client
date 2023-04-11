import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PostTile extends StatefulWidget {
  const PostTile({super.key});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(
                  'https://qph.cf2.quoracdn.net/main-qimg-e52c82fa77ccc4232f0da36682f7d0d7-lq'),
            ),
            const SizedBox(width: 20),
            Column(children: [
              Container(
                  width: 720,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Jack Maaye",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("@jackmye "),
                        Text(". 5d")
                      ])),
              const SizedBox(height: 10),
              Container(
                width: 720,
                child: Text(
                    style: TextStyle(fontFamily: 'FS'),
                    " the Container widget is set to Colors.white to make the background white. The Text widget is used to display the text inside the container. The textAlign property of the Text widget is set to TextAlign.center to center the text horizontally. You can adjust the width and height properties of theIn this example, the Container widget is used to display a blue container with a submit button."),
              ),
              const SizedBox(height: 5),
              Container(
                  width: 720,
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
    );
  }
}
