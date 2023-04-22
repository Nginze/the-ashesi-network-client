class User {
  final String userId;
  final String? studentId;
  final String emailAddress;
  final String userName;
  final String avatarUrl;
  final String? microsoftId;
  final String bio;
  final String favoriteFood;
  final String favoriteMovie;
  final String major;
  final String yearGroup;
  final String residency;
  final String dateOfBirth;

  User(
      {required this.userId,
      required this.studentId,
      required this.emailAddress,
      required this.userName,
      required this.avatarUrl,
      required this.microsoftId,
      required this.bio,
      required this.favoriteFood,
      required this.favoriteMovie,
      required this.major,
      required this.residency,
      required this.yearGroup,
      required this.dateOfBirth 
      });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      studentId: json['student_id'],
      userName: json['username'],
      avatarUrl: json['avatar_url'],
      bio: json['bio'],
      microsoftId: json['microsoft_id'],
      emailAddress: json['email_address'],
      favoriteFood: json['favorite_food'],
      favoriteMovie: json['favorite_movie'],
      major: json['major'],
      yearGroup: json['year_group'],
      residency: json['residency'],
      dateOfBirth: json['date_of_birth'],
    );
  }
}
