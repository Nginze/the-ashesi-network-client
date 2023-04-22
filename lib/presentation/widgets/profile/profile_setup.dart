import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_step_container/flutter_step_container.dart';
import 'package:frontend/data/models/user.dart';
import 'package:frontend/data/services/api/post_service.dart';
import 'package:frontend/data/services/api/user_service.dart';
import 'package:frontend/presentation/widgets/shared/create_modal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/user_provider.dart';

class ProfileSetup extends ConsumerStatefulWidget {
  const ProfileSetup({super.key});

  @override
  ConsumerState<ProfileSetup> createState() => _ProfileSetupState();
}

class _ProfileSetupState extends ConsumerState<ProfileSetup> {
  List<TextEditingController> _controllers = [];

  List<String> _placeholders = [
    "Student Id",
    "Username",
    "Email Address",
    "Date of Birth",
    "Year Group",
    "Major",
    "Residential Status",
    "Favourite Food",
    "Favourite Movie",
    "Bio"
  ];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(10, (_) => TextEditingController());
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  String _selectedYearGroup = '';
  String _selectedMajor = '';
  String _selectedResidency = '';

  List<String> _yearGroups = ['2023', '2024', '2025', '2026'];

  List<String> _majors = [
    'Business Admin.',
    'Computer Science',
    'Engineering',
    'Management Information Sys.'
  ];

  List<String> _residency = ['On-campus', 'Off-campus'];

  PostService postService = PostService();
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        width: 600,
        height: 600,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Center(
                child: Image(
                  image: AssetImage('assets/images/logo-text.png'),
                  width: 100,
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Column(children: [
                    Text(
                      'Edit your profile',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Align(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage: NetworkImage(
                                  ref.watch(userProvider).avatarUrl),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  splashRadius: 60,
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    // Handle button press
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ])),
              Container(
                width: 480,
                height: 250,
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index == 0) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.pin,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText: ref.watch(userProvider).studentId,
                                ),
                                controller: _controllers[index],
                              ),
                            );
                          }
                          if (index == 1) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText: ref.watch(userProvider).userName,
                                ),
                                controller: _controllers[index],
                              ),
                            );
                          }

                          if (index == 2) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText:
                                      ref.watch(userProvider).emailAddress,
                                ),
                                controller: _controllers[index],
                              ),
                            );
                          }

                          if (index == 3) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.card_giftcard,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText: ref.watch(userProvider).dateOfBirth,
                                ),
                                controller: _controllers[index],
                              ),
                            );
                          }

                          if (index == 4) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.group,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText: ref.watch(userProvider).yearGroup,
                                ),
                                controller: _controllers[index],
                              ),
                            );
                          }
                          if (index == 5) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                enabled: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.school,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText: ref.watch(userProvider).major,
                                ),
                                controller: _controllers[index],
                              ),
                            );
                          }
                          if (index == 6) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                enabled: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.location_city,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText: ref.watch(userProvider).residency,
                                ),
                                controller: _controllers[index],
                              ),
                            );
                          }
                          if (index == 7) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                enabled: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.restaurant_menu,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText:
                                      ref.watch(userProvider).favoriteFood,
                                ),
                                controller: _controllers[index],
                              ),
                            );
                          }
                          if (index == 8) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                enabled: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.movie,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText:
                                      ref.watch(userProvider).favoriteMovie,
                                ),
                                controller: _controllers[index],
                              ),
                            );
                          }
                          if (index == 9) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                enabled: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.book,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText: ref.watch(userProvider).bio,
                                ),
                                controller: _controllers[index],
                              ),
                            );
                          } else {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: _placeholders[index],
                                ),
                                controller: _controllers[index],
                              ),
                            );
                          }
                          ;
                        },
                        childCount: _placeholders.length,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 20, horizontal: 25)),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      iconSize: MaterialStateProperty.all(25.0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                    onPressed: () async {
                      User updatedUser = User(
                          userId: ref.watch(userProvider).userId,
                          studentId: ref.watch(userProvider).studentId,
                          emailAddress: ref.watch(userProvider).emailAddress,
                          userName: ref.watch(userProvider).userName,
                          dateOfBirth: ref.watch(userProvider).dateOfBirth,
                          avatarUrl: ref.watch(userProvider).avatarUrl,
                          microsoftId: ref.watch(userProvider).microsoftId,
                          bio: _controllers[9].text,
                          favoriteFood: _controllers[7].text,
                          favoriteMovie: _controllers[8].text,
                          major: _controllers[5].text,
                          residency: _controllers[6].text,
                          yearGroup: _controllers[4].text);
                      await userService.updateUser(updatedUser);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileSetupButton extends StatefulWidget {
  const ProfileSetupButton({super.key});

  @override
  State<ProfileSetupButton> createState() => _ProfileSetupButtonState();
}

class _ProfileSetupButtonState extends State<ProfileSetupButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
            side: MaterialStateProperty.resolveWith<BorderSide>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return BorderSide(color: Colors.grey, width: 1);
                }
                return BorderSide(color: Colors.blue, width: 1);
              },
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
            ),
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: 15, horizontal: 20))),
        child: Text(
          "Set up profile",
          style: TextStyle(color: Colors.blue),
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: ProfileSetup());
              });
        });
    // return const Placeholder();
  }
}
