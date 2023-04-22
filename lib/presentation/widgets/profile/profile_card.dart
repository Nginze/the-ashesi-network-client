import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/user.dart';
import 'package:frontend/presentation/widgets/profile/profile_setup.dart';
import 'package:frontend/providers/user_provider.dart';

class ProfileCard extends ConsumerWidget {
  // const ProfileCard({super.key});
  final User? user;
  const ProfileCard({Key? key, required this.user}) : super(key: key);

//   @override
//   State<ProfileCard> createState() => _ProfileCardState();
// }

// class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Column(
          children: [
            user != null
                ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Color.fromARGB(125, 158, 158, 158),
                            // backgroundImage: NetworkImage(
                            //    widget.user!.avatarUrl),
                            backgroundImage: user!.avatarUrl != null
                                ? NetworkImage(user!.avatarUrl)
                                    as ImageProvider<Object>?
                                : const AssetImage(
                                    'assets/images/default_profile.png'),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user!.userName,
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Text("0 followers"),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text("0 followers")
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  ref.watch(userProvider).userId != user!.userId
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: ElevatedButton.icon(
                                            style: ButtonStyle(
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        0),
                                                padding:
                                                    MaterialStateProperty.all(
                                                        EdgeInsets.symmetric(
                                                            vertical: 15,
                                                            horizontal: 15))),
                                            onPressed: () {},
                                            icon:
                                                Icon(EvaIcons.personAddOutline),
                                            label: Text("Follow"),
                                          ))
                                      : ProfileSetupButton()
                                ],
                              )
                            ],
                          )
                        ]),
                    // SizedBox(
                    //   width: 250,
                    // ),
                  ])
                : Center(),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        EvaIcons.person,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('${user!.bio}')
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        EvaIcons.pinOutline,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('${user!.residency}')
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.movie_creation_outlined,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('${user!.favoriteMovie}')
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.restaurant_menu_outlined,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('${user!.favoriteFood}')
                    ],
                  ),
                ])
              ]),
            )
          ],
        ));
  }
}
