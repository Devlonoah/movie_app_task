// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:movie_app_task/bloc/authentication/authentication_event.dart';

import 'package:movie_app_task/data/repository/configuration_repository.dart';
import 'package:movie_app_task/data/repository/user_repository.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  final ConfigurationRepository _configurationRepository;
  AuthenticationBloc(
    this.userRepository,
    this._configurationRepository,
  ) : super(AuthenticationInitial()) {
    on<AuthenticateWithSavedCredentialEvent>((event, emit) async {
      emit(AuthenticationInProgress());
      try {
        emit(AuthenticationSuccessful());
      } on SocketException {
        emit(const AuthenticationFailed(errorMessage: "Network Failure"));
      } catch (e) {
        emit(const AuthenticationFailed());
      }
    });

    on<AuthenticateWithEmailAndPassword>((event, emit) async {
      try {
        emit(AuthenticationInProgress());

        _configurationRepository.setRememberMeStatus(
          event.rememberMe,
        );

        final result = await userRepository.login(
          email: event.email,
          password: event.password,
        );

        emit(AuthenticationSuccessful());
      } catch (e) {
        emit(const AuthenticationFailed());
      }
    });

    on<AuthenticateWithSavedCredential>((event, emit) async {
      emit(AuthenticationInProgress());
      var isTokenExist = await userRepository.hasToken();
      if (isTokenExist) {
        emit(AuthenticationSuccessful());
      } else {
        emit(const AuthenticationFailed());
      }
    });
  }


}
