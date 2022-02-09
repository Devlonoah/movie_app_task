import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:movie_app_task/data/repository/configuration_repository.dart';
import 'package:movie_app_task/data/repository/user_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(
    this.userRepository,
    this._configurationRepository,
  ) : super(AuthenticationInitial());

  final UserRepository userRepository;

  final ConfigurationRepository _configurationRepository;
  void authenticateWithSavedCredential() async {
    try {
      emit(AuthenticationInProgress());

      emit(AuthenticationSuccessful());
    } on SocketException {
      emit(const AuthenticationFailed(errorMessage: "Network Failure"));
    } catch (e) {
      emit(const AuthenticationFailed());
    }
  }

  void login({
    required String email,
    required String password,
    required bool rememberMe,
  }) {
    emit(AuthenticationInProgress());
    try {
      _configurationRepository.setRememberMeStatus(rememberMe);

      final result = userRepository.login(
        email: email,
        password: password,
      );

      emit(AuthenticationSuccessful());
    } catch (e) {
      emit(const AuthenticationFailed());
    }
  }
}
