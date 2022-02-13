import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:movie_app_task/data/models/user_model.dart';

class AuthenticationDataSource {
  final baseUrl = 'https://zm-movies-assignment.herokuapp.com/api/auth/local';
  Future<UserModel> login(
      {required String email, required String password}) async {
    final body = {
      "identifier": email,
      "password": password,
    };
    final response = await post(Uri.parse(baseUrl), body: body, headers: {
      HttpHeaders.acceptEncodingHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
    });
    print("response body: ${response.body}");
    print("response body ${response.statusCode}");

    if (response.statusCode == 200) {
      return UserModel.fromMap(jsonDecode(response.body));
    } else {
      throw AuthException();
    }
  }
}

class AuthException implements Exception {}
