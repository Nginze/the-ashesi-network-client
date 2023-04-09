// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html';
import 'package:frontend/data/models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://localhost:5000/auth';

  Future<User> login(String emailAddress, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email_address': emailAddress,
        'password': password
      }),
    );

    if (response.statusCode == 200) {
      final loggedInUser = User.fromJson(jsonDecode(response.body));
      return loggedInUser;
    } else {
      throw Exception('Login Failed');
    }
  }

  Future<User> signUp(String emailAddress, String password, String username,
      String studentId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email_address': emailAddress,
        'password': password,
        'student_id': studentId
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
      baseUrl,
      'The Ashesi Network',
      'width=$width,height=$height,left=$left,top=$top',
    );
  }

  Future<void> logout() async {
    final response = await http.get(
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