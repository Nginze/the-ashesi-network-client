// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html';
import 'package:frontend/data/models/user.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static bool isprod = true;
  final String baseUrl = isprod
      ? 'https://flask-production-b88c.up.railway.app/auth'
      : 'http://localhost:5000/auth';
  final http.Client _client = http.Client();

  Future<User> getMe() async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.get(Uri.parse('$baseUrl/user'));
    final json = jsonDecode(response.body);
    if (json['msg'] == 'no user') {
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
          dateOfBirth: '');
    }
    return User.fromJson(json);
  }

  Future<User> login(String emailAddress, String password) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Credentials': 'true'
      },
      body: jsonEncode(<String, String>{
        'email_address': emailAddress,
        'password': password
      }),
    );

    print(response.headers);
    if (response.statusCode == 200) {
      final loggedInUser = User.fromJson(jsonDecode(response.body));
      return loggedInUser;
    } else {
      throw Exception('Login Failed');
    }
  }

  Future<User> signUp(String emailAddress, String password, String username,
      String studentId) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.post(
      Uri.parse('$baseUrl/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email_address': emailAddress,
        'password': password,
        'student_id': studentId,
        'username': username
      }),
    );

    if (response.statusCode == 200) {
      final loggedInUser = User.fromJson(jsonDecode(response.body));
      return loggedInUser;
    } else {
      throw Exception('Signup Failed');
    }
  }

  void loginWithMicrosoft() {
    const width = 500;
    const height = 600;
    final left = (window.screen!.width! - width) ~/ 2;
    final top = (window.screen!.height! - height) ~/ 2;

    window.open(
      '$baseUrl/microsoft',
      'The Ashesi Network',
      'width=$width,height=$height,left=$left,top=$top',
    );
  }

  Future<void> logout() async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.get(
      Uri.parse('$baseUrl/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Logout Failed');
    }
  }
}
