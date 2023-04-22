import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/data/models/comment.dart';

class CommentService {
  final String baseUrl = 'http://localhost:5000/posts';
  final http.Client _client = http.Client();

  Future<Comment> getComment(String commentId) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.get(Uri.parse('$baseUrl/$commentId'));
    final json = jsonDecode(response.body);
    return Comment.fromJson(json);
  }

  Future<void> createComment(String content, String postId, String parentId) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.post(
      Uri.parse('$baseUrl/$postId/comment'),
      body: jsonEncode({
        'content': content,
        'parent_id': parentId != '' ? parentId : null
      }),
    );
    if (response.statusCode != 200) {

      Fluttertoast.showToast(
          msg: "Comment Failed! Try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          webPosition: 'center',
          webBgColor: "#101110",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      throw Exception('Failed to create comment');


    }else{
      Fluttertoast.showToast(
          msg: "Comment Created",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          webPosition: 'center',
          webBgColor: "#101110",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> deleteComment(String commentId) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.delete(Uri.parse('$baseUrl/$commentId'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete comment');
    }
  }

Future<List<Comment>> getReplies(String postId, String parentId) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.get(
      Uri.parse('$baseUrl/$postId/$parentId/reply/all'),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return List<Comment>.from(
        json['data'].map((commentJson) => Comment.fromJson(commentJson)),
      );
    } else {
      throw Exception('Failed to get replies');
    }
  }

}
