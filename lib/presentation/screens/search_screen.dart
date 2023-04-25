import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/presentation/screens/suggestion_screen.dart';
import 'package:frontend/presentation/widgets/people/people_query_view.dart';
import 'package:frontend/presentation/widgets/people/people_view.dart';
import 'package:frontend/presentation/widgets/shared/layout.dart';
import 'package:frontend/presentation/widgets/shared/right_sidebar.dart';

class SearchPage extends StatefulWidget {
  final String query;
  const SearchPage({super.key, required this.query});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Layout(
        main: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: PeopleQueryView(widget.query)),
        right: RightNavigationBar());
  }
}
