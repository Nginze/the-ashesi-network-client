import 'package:flutter/material.dart';
import 'package:flutter_step_container/flutter_step_container.dart';
import 'package:frontend/presentation/widgets/shared/create_modal.dart';

class ProfileSetup extends StatefulWidget {
  const ProfileSetup({super.key});

  @override
  State<ProfileSetup> createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
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
    "Favourite Movie"
  ];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(9, (_) => TextEditingController());
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

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
                              backgroundImage:
                                  NetworkImage('https://picsum.photos/200/300'),
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
                width: 500,
                height: 250,
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
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
                        },
                        childCount: 9,
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
                    onPressed: () {},
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
