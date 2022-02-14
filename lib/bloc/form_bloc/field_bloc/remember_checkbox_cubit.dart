import '../field_bloc.dart';
import '../validation_state.dart';

///Thi cubit holds boolean value
///
///From the [Remember me checkbox] default to false

class RememberCheckboxBloc extends FieldBloc<bool> {
  RememberCheckboxBloc(ValidationState<bool> initialState)
      : super(initialState) {
    on<bool>((event, emit) {
      print("event added $event");
      if (event) {
        emit(ValidState(event));
      } else {
        emit(InvalidState(event));
      }
    });
  }
}
