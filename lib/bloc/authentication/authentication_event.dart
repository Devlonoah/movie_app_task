abstract class AuthenticationEvent {}

class AuthenticateWithSavedCredentialEvent extends AuthenticationEvent {}

//
class AuthenticateWithEmailAndPassword extends AuthenticationEvent {
  final String email;
  final String password;
  final bool rememberMe;

  AuthenticateWithEmailAndPassword(
      {required this.email, required this.password, required this.rememberMe});
}

//app started
class AuthenticateWithSavedCredential extends AuthenticationEvent {}
