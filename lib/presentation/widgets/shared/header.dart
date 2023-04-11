import 'dart:html';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/utils/constants.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        height: 50,
        decoration: const BoxDecoration(
            color: Colors.transparent,
            border: Border(
                bottom: BorderSide(
                    color: Color.fromARGB(111, 138, 138, 138), width: 0.3))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/logo_no_text.png',
                  width: 40,
                ),
                const SizedBox(width: 10),
                Container(
                    width: 350,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const TextField(
                      decoration: InputDecoration( 
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        prefixIcon: Icon(Icons.search), 
                        fillColor: Color.fromARGB(169, 235, 235, 235),
                        filled: true,
                        hintStyle: TextStyle(
                          fontSize: 14
                        ),
                        hintText: 'Search',
                      ),
                    ))
              ],
            ),
            Row(
              children: [
                SizedBox(
                    height: 35,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          iconSize: MaterialStateProperty.all<double>(20),
                          elevation: MaterialStateProperty.all<double>(0.0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppTheme.primaryColor)),
                      label: const Text("Create"),
                      onPressed: () => {},
                      icon: const Icon(Icons.add),
                    )),
                const SizedBox(width: 15),
                IconButton(
                    splashRadius: 20,
                    color: Color.fromARGB(255, 112, 112, 112),
                    iconSize: 22,
                    onPressed: () {},
                    icon: const Icon(EvaIcons.bellOutline)),
                const SizedBox(width: 15),
                PopupMenuButton<String>(
                  splashRadius: 20,
                  iconSize: 30,
                  icon: const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                        'https://qph.cf2.quoracdn.net/main-qimg-e52c82fa77ccc4232f0da36682f7d0d7-lq'),
                  ),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'profile',
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text('My Profile'),
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'logout',
                      child: ListTile(
                        leading: Icon(Icons.logout, color: Colors.red),
                        title: Text('Logout'),
                      ),
                    ),
                  ],
                  onSelected: (String value) {
                    if (value == 'profile') {
                      // Navigate to profile screen
                    } else if (value == 'logout') {
                      // Perform logout operation
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
