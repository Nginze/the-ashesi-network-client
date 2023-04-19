import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';

class SuggestedTile extends StatefulWidget {
  const SuggestedTile({super.key});

  @override
  State<SuggestedTile> createState() => _SuggestedTileState();
}

class _SuggestedTileState extends State<SuggestedTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Row(children: [
        Container(
          child: const CircleAvatar(
              radius: 22,
              backgroundColor: Colors.blue,
              backgroundImage: AssetImage('assets/images/default_profile.png')),
        ),
        SizedBox(
          width: 15,
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Text(
                    'Jonathan',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    '@jonathan123',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          width: 65,
        ),
        Container(
            child: OutlinedButton(
          style: ButtonStyle(
              side: MaterialStateProperty.resolveWith<BorderSide>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return BorderSide(color: Colors.grey, width: 1);
                  }
                  return BorderSide(color: Colors.blue, width: 1);
                },
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                ),
              ),
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20))),
          child: Text(
            "Follow",
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () {},
        ))
      ]),
    );
  }
}
