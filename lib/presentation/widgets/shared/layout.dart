import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/home/feed_view.dart';
import 'package:frontend/presentation/widgets/shared/left_sidebar.dart';
import 'package:frontend/presentation/widgets/shared/right_sidebar.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Flexible(
          flex: 2,
          child: Container(
            child: const LeftNavigationBar(),
          ),
        ),
        Container(
          width: 600.0,
          decoration: const BoxDecoration(
              border: Border(
                  left: BorderSide(width: 0.5, color: Colors.grey),
                  right: BorderSide(width: 0.5, color: Colors.grey))),
          child: FeedView(),
        ),
        Flexible(
          flex: 3,
          child: Container(
            child: RightNavigationBar(),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
