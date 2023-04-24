import 'package:flutter/material.dart';
import 'package:frontend/data/models/user.dart';
import 'package:frontend/presentation/widgets/shared/suggested_tile.dart';
import 'package:frontend/utils/constants.dart';
import 'package:go_router/go_router.dart';

class SuggestionsBox extends StatefulWidget {
  final List<dynamic> suggestions;
  const SuggestionsBox({super.key, required this.suggestions});

  @override
  State<SuggestionsBox> createState() => _SuggestionsBoxState();
}

class _SuggestionsBoxState extends State<SuggestionsBox> {
  // List<String> _suggestions = ["a", "b", "c"];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
          color: Color.fromARGB(18, 124, 190, 243),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "You might like",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 270,
          child: widget.suggestions.isNotEmpty
              ? ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    if (index == 2) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SuggestedTile(
                            suggestion: widget.suggestions[index],
                          ),
                          TextButton(
                            onPressed: () {
                              context.go('/suggestions');
                            },
                            child: Text("Show more"),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(36),
                                )),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 15))),
                          )
                        ],
                      );
                    }
                    return SuggestedTile(
                      suggestion: widget.suggestions[index],
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(),
                ),
        )
      ]),
    );
  }
}
