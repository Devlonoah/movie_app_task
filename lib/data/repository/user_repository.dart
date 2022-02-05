import 'package:movie_app_task/core/authentication_base_class.dart';
import 'package:movie_app_task/data/data_source/authentication_data_source.dart';

class UserRepository implements AuthenticationBaseClass {
  UserRepository(AuthenticationDataSource authenticationDataSource)
      : _authenticationDataSource = authenticationDataSource;

  final AuthenticationDataSource _authenticationDataSource;

  @override
  Future<String> login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<String> signUp() {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
