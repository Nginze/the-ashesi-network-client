import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/home/post_tile.dart';
import 'package:frontend/presentation/widgets/shared/feed_input.dart';
import 'package:frontend/presentation/widgets/shared/header.dart';
import 'package:frontend/presentation/widgets/shared/left_sidebar.dart';
import 'package:frontend/presentation/widgets/shared/right_sidebar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Header(),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Expanded(
                        child: SizedBox(
                      height: 500,
                      child: LeftNavigationBar(),
                    )),
                    const SizedBox(width: 30),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 620,
                        child: SingleChildScrollView (
                          child: Column(children: [
                            FeedInput(),
                            PostTile(),
                            PostTile(),
                            PostTile(),
                            PostTile()
                          ]),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    const Expanded(
                      child: SizedBox(
                        height: 500,
                        width: double.infinity,
                        child: RightNavigationBar()
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}
