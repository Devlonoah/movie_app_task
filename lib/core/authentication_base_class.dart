abstract class AuthenticationBaseClass<Type> {
  Future<Type> login();

  Future<Type> signUp();
}
