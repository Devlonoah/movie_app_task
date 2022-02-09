import 'package:movie_app_task/core/keys.dart';
import 'package:movie_app_task/data/data_source/authentication_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  UserRepository({
    required this.authenticationDataSource,
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  final AuthenticationDataSource authenticationDataSource;

  Future<String> login({
    required String email,
    required String password,
  }) async {
    final result = await authenticationDataSource.login(
      email: email,
      password: password,
    );

    return result;
  }

  Future<String> loginWithSavedCredential() async {
    final email = sharedPreferences.getString(AppKey.email);
    final password = sharedPreferences.getString(AppKey.password);

    final result = await authenticationDataSource.login(
        email: email!, password: password!);
    return result;
  }
}
