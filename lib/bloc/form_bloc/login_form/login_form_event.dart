part of 'login_form_bloc.dart';

class LoginFormEvent {
  const LoginFormEvent({
    this.email,
    this.password,
    this.rememberMe = false,
  });

  final ValidationState<String>? email;

  final ValidationState<String>? password;
  final bool rememberMe;
}
