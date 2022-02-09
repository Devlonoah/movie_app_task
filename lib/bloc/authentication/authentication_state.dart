part of 'authentication_cubit.dart';

abstract class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationInProgress extends AuthenticationState {}

class AuthenticationSuccessful extends AuthenticationState {}

class AuthenticationFailed extends AuthenticationState {
  final String errorMessage;

  const AuthenticationFailed({this.errorMessage = "Error Occured"});
}
