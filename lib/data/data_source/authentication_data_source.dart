import 'dart:io';

import 'package:http/http.dart';

class AuthenticationDataSource {
  final baseUrl = 'https://zm-movies-assignment.herokuapp.com/api/auth/local';
  Future login({required String email, required String password}) async {
    final body = {
      "identifier": email,
      "password": password,
    };
    final response = await post(Uri.parse(baseUrl), body: body, headers: {
      HttpHeaders.acceptEncodingHeader: "application/json",
    });
    print(response.body);
    print(response.statusCode);
    return response.body;
  }
}
