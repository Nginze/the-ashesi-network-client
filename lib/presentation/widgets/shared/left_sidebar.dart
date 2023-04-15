import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/constants.dart';

class LeftNavigationBar extends StatefulWidget {
  const LeftNavigationBar({super.key});

  @override
  State<LeftNavigationBar> createState() => _LeftNavigationBarState();
}

class _LeftNavigationBarState extends State<LeftNavigationBar> {
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
        controller: sideMenu,
        onDisplayModeChanged: (mode) {
          print(mode);
        },
        style: SideMenuStyle(
            displayMode: SideMenuDisplayMode.auto,
            
            unselectedTitleTextStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            hoverColor: Color.fromARGB(22, 163, 59, 62),
            selectedColor: Color.fromARGB(18, 163, 59, 62),
            selectedTitleTextStyle: const TextStyle(
                fontSize: 16,
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold),
            selectedIconColor: AppTheme.primaryColor),
        items: <SideMenuItem>[
          SideMenuItem(
            priority: 0,
            title: 'Home',
            onTap: (page, _) {
              sideMenu.changePage(page);
            },
            icon: const Icon(EvaIcons.homeOutline),
          ),
          SideMenuItem(
            priority: 1,
            title: 'Bookmarks',
            onTap: (page, _) {
              sideMenu.changePage(page);
            },
            icon: const Icon(EvaIcons.bookmarkOutline),
          ),
          SideMenuItem(
            priority: 2,
            title: 'Communities',
            onTap: (page, _) {
              sideMenu.changePage(page);
            },
            icon: const Icon(EvaIcons.peopleOutline),
          ),
          
        ]);
  }
}
