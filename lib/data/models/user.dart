class User {
  final String userId;
  final String studentId;
  final String emailAddress;
  final String userName;
  final String avatarUrl;
  final String microsoftId;
  final String bio;

  User({
    required this.userId,
    required this.studentId,
    required this.emailAddress,
    required this.userName,
    required this.avatarUrl,
    required this.microsoftId,
    required this.bio,
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
    );
  }
}