part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationInProgress extends AuthenticationState {}

class AuthenticationSuccessful extends AuthenticationState {}

class AuthenticationFailed extends AuthenticationState {
  final String errorMessage;

  const AuthenticationFailed({this.errorMessage = "Error Occured"});
}
