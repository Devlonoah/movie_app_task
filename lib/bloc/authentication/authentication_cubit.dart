import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app_task/data/repository/user_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this.userRepository) : super(AuthenticationInitial());

  final UserRepository userRepository;
  void authenticateWithSavedCredential() async {
    try {
      emit(AuthenticationInProgress());

      final result = await userRepository.loginWithSavedCredential();

      emit(AuthenticationSuccessful());
    } on SocketException {
      emit(const AuthenticationFailed(errorMessage: "Network Failure"));
    } catch (e) {
      emit(const AuthenticationFailed());
    }
  }
}
