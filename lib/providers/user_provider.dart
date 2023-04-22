import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/user.dart';
import 'package:frontend/data/services/api/auth_service.dart';

final userLoadingProvider = StateProvider((ref) => true);

final userProvider = StateProvider<User>((ref) {
  return User(
      userId: '',
      studentId: '',
      emailAddress: '',
      userName: '',
      avatarUrl: '',
      microsoftId: '',
      bio: '',
      favoriteFood: '',
      favoriteMovie: '',
      major: '',
      residency: '',
      yearGroup: '',
      dateOfBirth: ''
      );
});
