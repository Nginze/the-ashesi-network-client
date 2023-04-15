import 'dart:js';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailedAppBar extends StatelessWidget {
  final String title;

  DetailedAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Row(
        children: [
          IconButton(
            splashRadius: 20,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.go('/');
            },
          ),
          Text(title, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),),
        ],
      ),
    );
  }

}