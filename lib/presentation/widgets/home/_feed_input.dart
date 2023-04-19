import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/shared/create_modal.dart';

class NewFeedInput extends StatefulWidget {
  const NewFeedInput({super.key});

  @override
  State<NewFeedInput> createState() => _NewFeedInputState();
}

class _NewFeedInputState extends State<NewFeedInput> {
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
                              child: CustomModal());
                        });
                  },
                  maxLines: 2,
                  decoration: InputDecoration(
                      hintText: "What's happening?", border: InputBorder.none),
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
                                        child: CustomModal());
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
                                        child: CustomModal());
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
                            "Post",
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
