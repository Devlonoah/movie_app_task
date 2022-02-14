import '../field_bloc.dart';
import '../validation_state.dart';

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
