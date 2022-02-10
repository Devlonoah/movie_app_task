abstract class AuthenticationEvent {}

class AuthenticateWithSavedCredentialEvent {}

class AuthenticateWithEmailAndPassword {
  final String email;
  final String password;

  AuthenticateWithEmailAndPassword({
    required this.email,
    required this.password,
  });
}
