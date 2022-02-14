import 'dart:async';

import 'package:bloc/bloc.dart';

import '../field_bloc/email_field_bloc.dart';
import '../field_bloc/password_bloc.dart';
import '../field_bloc/remember_checkbox_cubit.dart';
import '../validation_state.dart';

part 'login_form_event.dart';

class LoginFormBloc
    extends Bloc<LoginFormEvent, ValidationState<LoginDetails>> {
  final EmailFieldBloc emailFieldBloc;
  final PasswordBloc passwordBloc;
  final RememberCheckboxBloc rememberCheckboxBloc;
  late StreamSubscription emailStream;

  late StreamSubscription passwordStream;

  late StreamSubscription rememberCheckboxStream;

  LoginFormBloc({
    required this.emailFieldBloc,
    required this.passwordBloc,
    required this.rememberCheckboxBloc,
  }) : super(InvalidState(LoginDetails(
          email: '',
          password: '',
          rememberMe: false,
        ))) {
    emailStream = emailFieldBloc.stream.listen((_) {
      add(LoginFormEvent(email: _));
    });

    passwordStream = passwordBloc.stream.listen((_) {
      add(LoginFormEvent(password: _));
    });

    rememberCheckboxStream = rememberCheckboxBloc.stream.listen((_) {
      add(LoginFormEvent(rememberMe: _.data));
    });

    on<LoginFormEvent>((event, emit) {
      final isValid = emailFieldBloc.state is ValidState &&
          passwordBloc.state is ValidState;

      if (isValid) {
        emit(ValidState(LoginDetails(
          email: emailFieldBloc.state.data,
          password: passwordBloc.state.data,
          rememberMe: rememberCheckboxBloc.state.data,
        )));
      }
    });
  }
}

class LoginDetails {
  final String email;
  final String password;
  final bool rememberMe;

  LoginDetails({
    required this.email,
    required this.password,
    required this.rememberMe,
  });
}
