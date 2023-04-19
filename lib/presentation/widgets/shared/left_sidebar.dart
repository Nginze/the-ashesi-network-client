import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/constants.dart';
import 'package:boxicons/boxicons.dart';
import 'package:go_router/go_router.dart';

class LeftNavigationBar extends StatefulWidget {
  const LeftNavigationBar({super.key});

  @override
  State<LeftNavigationBar> createState() => _LeftNavigationBarState();
}

class _LeftNavigationBarState extends State<LeftNavigationBar> {

  static const List<Map<String, dynamic>> _navItems = [
    {
      'label': 'Home',
      'icon': Icon(Boxicons.bx_home, color: Color.fromARGB(202, 0, 0, 0)),
      'location': '/home'
    },
    {
      'label': 'Bookmarks',
      'icon': Icon(Boxicons.bx_bookmark, color: Color.fromARGB(202, 0, 0, 0)),
      'location': '/favorites'
    },
    {
      'label': 'Profile',
      'icon': Icon(Icons.person, color: Color.fromARGB(202, 0, 0, 0)),
      'location': '/settings'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: _navItems.length,
      itemBuilder: (context, index) {
        Map currentItem = _navItems[index];
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Image(
                  image: AssetImage('assets/images/logo-text.png'),
                  width: 100,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: NavButton(
                    label: currentItem['label'],
                    icon: currentItem['icon'],
                    location: currentItem['location']),
              )
            ],
          );
        }
        if (index == _navItems.length - 1) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: NavButton(
                    label: currentItem['label'],
                    icon: currentItem['icon'],
                    location: currentItem['location']),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 200,
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 20, horizontal: 35)),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      iconSize: MaterialStateProperty.all(25.0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Post",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(
                height: 340,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ProfileButton(),
              )
            ],
          );
        }
        return Align(
          alignment: Alignment.centerLeft,
          child: NavButton(
              label: currentItem['label'],
              icon: currentItem['icon'],
              location: currentItem['location']),
        );
      },
    ));
    // return SideMenu(
    //     controller: sideMenu,
    //     onDisplayModeChanged: (mode) {
    //       print(mode);
    //     },
    //     style: SideMenuStyle(
    //         displayMode: SideMenuDisplayMode.auto,

    //         unselectedTitleTextStyle:
    //             const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    //         hoverColor: Color.fromARGB(22, 163, 59, 62),
    //         selectedColor: Color.fromARGB(18, 163, 59, 62),
    //         selectedTitleTextStyle: const TextStyle(
    //             fontSize: 16,
    //             color: AppTheme.primaryColor,
    //             fontWeight: FontWeight.bold),
    //         selectedIconColor: AppTheme.primaryColor),
    //     items: <SideMenuItem>[
    //       SideMenuItem(
    //         priority: 0,
    //         title: 'Home',
    //         onTap: (page, _) {
    //           sideMenu.changePage(page);
    //         },
    //         icon: const Icon(EvaIcons.homeOutline),
    //       ),
    //       SideMenuItem(
    //         priority: 1,
    //         title: 'Bookmarks',
    //         onTap: (page, _) {
    //           sideMenu.changePage(page);
    //         },
    //         icon: const Icon(EvaIcons.bookmarkOutline),
    //       ),
    //       SideMenuItem(
    //         priority: 2,
    //         title: 'Communities',
    //         onTap: (page, _) {
    //           sideMenu.changePage(page);
    //         },
    //         icon: const Icon(EvaIcons.peopleOutline),
    //       ),

    //     ]);
  }
}

class NavButton extends StatelessWidget {
  final String label;
  final Icon icon;
  final String location;

  const NavButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton.icon(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: 20, horizontal: 15)),
          iconSize: MaterialStateProperty.all(25.0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36),
            ),
          ),
        ),
        icon: icon,
        label: Text(
          label,
          style: const TextStyle(
              color: Color.fromARGB(202, 0, 0, 0), fontSize: 20.0),
        ),
        onPressed: () {
          context.go(location);
        },
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Row(children: [
        Container(
          child: const CircleAvatar(
              radius: 22,
              backgroundColor: Colors.blue,
              backgroundImage: AssetImage('assets/images/default_profile.png')),
        ),
        SizedBox(
          width: 15,
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Text(
                    'Jonathan',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    '@jonathan123',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          width: 25,
        ),
        Container(child: Icon(Boxicons.bx_dots_horizontal_rounded))
      ]),
    );
  }
}
