import 'package:movie_app_task/bloc/form_bloc/field_bloc.dart';
import 'package:movie_app_task/bloc/form_bloc/validation_state.dart';

class PasswordBloc extends FieldBloc<String> {
  PasswordBloc(ValidationState<String> initialState) : super(initialState) {
    on<String>((event, emit) {
      if (event.length < requiredPasswordLength) {
        emit(InvalidState(event));
      } else {
        emit(ValidState(event));
      }
    });
  }

  final requiredPasswordLength = 6;
}
