import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/utils/constants.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Stack(
        children: [
          Container(
            width: 340,
            child: const TextField(
              decoration: InputDecoration(
                  hintText: 'Search the Ashesi Network',
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(55.0))),
                  filled: true,
                  prefixIcon: Icon(Boxicons.bx_search_alt),
                  fillColor: Color.fromARGB(76, 222, 223, 223),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
