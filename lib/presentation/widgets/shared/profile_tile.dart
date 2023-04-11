import 'package:flutter/material.dart';

class ProfileTile extends StatefulWidget {
  const ProfileTile({super.key});

  @override
  State<ProfileTile> createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () {},
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            'data:image/jpeg;base64,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',
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          )),
                      const SizedBox(width: 10),
                      const Text(
                        "Kweku Boateng",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      )
                    ]))),
      ],
    );
  }
}
