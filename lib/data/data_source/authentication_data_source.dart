import 'package:http/http.dart';

class AuthenticationDataSource {
  final baseUrl = 'https://zm-movies-assignment.herokuapp.com/api/auth/local';
  @override
  Future login({required String email, required String password}) async {
    final body = {"identifier": email, "password": password};
    final response = await post(
      Uri.parse(baseUrl + ""),
      body: body,
    );

    print(response.statusCode);
    print(response.body);
  }
}
