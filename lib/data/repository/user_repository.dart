import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movie_app_task/core/keys.dart';
import 'package:movie_app_task/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:movie_app_task/data/data_source/authentication_data_source.dart';

class UserRepository {
  UserRepository({
    required this.sharedPreferences,
    required this.authenticationDataSource,
    required this.secureStorage,
  });

  final SharedPreferences sharedPreferences;
  final FlutterSecureStorage secureStorage;
  final AuthenticationDataSource authenticationDataSource;

  Future<UserModel> login(
      {required String email, required String password}) async {
    final result = await authenticationDataSource.login(
      email: email,
      password: password,
    );
    await secureStorage.write(key: AppKey.jwtToken, value: result.jwt);

    return result;
  }

  Future<bool> hasToken() async {
    return await secureStorage.read(key: AppKey.jwtToken) != null;
  }

  Future setToken(String token) async {
    await secureStorage.write(key: AppKey.jwtToken, value: token);
  }

  Future<String?> getToken() async {
    return await secureStorage.read(key: AppKey.jwtToken);
  }
}
