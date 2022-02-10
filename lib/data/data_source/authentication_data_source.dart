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
    });
    print("response body: ${response.body}");
    print("response body ${response.statusCode}");

    return UserModel.fromMap(jsonDecode(response.body));
  }
}
