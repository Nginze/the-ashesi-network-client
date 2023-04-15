import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/user.dart';

final userProvider = StateProvider<User>((ref) => User(
    avatarUrl: "",
    bio: "",
    emailAddress: "",
    microsoftId: "",
    studentId: "",
    userId: "",
    userName: ""));

