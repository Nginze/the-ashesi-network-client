import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/shared/community_tile.dart';
import 'package:frontend/presentation/widgets/shared/profile_tile.dart';

class RightNavigationBar extends StatefulWidget {
  const RightNavigationBar({super.key});

  @override
  State<RightNavigationBar> createState() => _RightNavigationBarState();
}

class _RightNavigationBarState extends State<RightNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Top Communities",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextButton(onPressed: () {}, child: const Text("See All")),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: [
            CommunityTile(),
            CommunityTile(),
            CommunityTile(),
            CommunityTile(),
            CommunityTile()
          ],
        ),

        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Suggested People",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextButton(onPressed: () {}, child: const Text("See All"))
          ],
        ),
        Column(
          children: [
            ProfileTile(),
            ProfileTile(),
            ProfileTile(),
            ProfileTile(),
            ProfileTile()
          ],
        )
      ],
    );
  }
}
