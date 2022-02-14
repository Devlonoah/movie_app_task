import '../field_bloc.dart';
import '../validation_state.dart';

class EmailFieldBloc extends FieldBloc<String> {
  static final initailState = InitialState('');

  static final RegExp _emailPattern = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  EmailFieldBloc(ValidationState<String> initialState) : super(initialState) {
    on<String>((event, emit) {
      if (_emailPattern.hasMatch(event)) {
        emit(ValidState(event));
      } else {
        emit(InvalidState(event));
      }
    });
  }
}
