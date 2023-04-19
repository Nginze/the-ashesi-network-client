import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/models/post.dart';
import 'package:frontend/data/services/api/user_service.dart';
import 'package:frontend/presentation/widgets/home/post_tile.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);
  
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final ScrollController _scrollController;

  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userService = UserService();
    return Column(children: [
      TabBar(
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              _handleTabSelection();
            });
          },
          controller: _tabController,
          labelColor: Colors.grey,
          tabs: [
            Tab(text: "Created", icon: Icon(EvaIcons.gridOutline)),
            Tab(
              text: "Saved",
              icon: Icon(EvaIcons.bookmarkOutline),
            ),
          ]),
      _selectedIndex == 0
          ? Container(
              height: 280,
              child: FutureBuilder<List<Post>>(
                future: userService.getCreated(0),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return PostTile(post: snapshot.data![index]);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return CircularProgressIndicator();
                },
              ))
          : Container(
              height: 280,
              child: FutureBuilder<List<Post>>(
                future: userService.getSaved(0),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return PostTile(post: snapshot.data![index]);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return CircularProgressIndicator();
                },
              )),
      // TabBarView(
      //   controller: _tabController,
      //   children: [
      // ])
    ]);
  }
}
