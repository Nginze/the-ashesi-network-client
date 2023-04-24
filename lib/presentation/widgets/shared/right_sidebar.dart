import 'package:flutter/material.dart';
import 'package:frontend/data/services/api/user_service.dart';
import 'package:frontend/presentation/widgets/shared/community_tile.dart';
import 'package:frontend/presentation/widgets/shared/profile_tile.dart';
import 'package:frontend/presentation/widgets/shared/search_input.dart';
import 'package:frontend/presentation/widgets/shared/suggested_container.dart';

class RightNavigationBar extends StatefulWidget {
  const RightNavigationBar({super.key});

  @override
  State<RightNavigationBar> createState() => _RightNavigationBarState();
}

class _RightNavigationBarState extends State<RightNavigationBar> {
  final UserService userService = UserService();
  List<dynamic> suggestions = [];

  void _fetchData() async {
    List<dynamic> newSuggestions = await userService.getSuggested();
    print(newSuggestions);
    setState(() {
      suggestions.addAll(newSuggestions);
    });
    print(await userService.getSuggested());
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SearchInput(),
          // const SizedBox(height: 15,),
          SuggestionsBox(
            suggestions: suggestions,
          )
        ],
      ),
    );
  }
}
