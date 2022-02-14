import 'package:bloc/bloc.dart';
import '../../form_bloc/validation_state.dart';

class PublishYearBloc extends Bloc<String, ValidationState<String>> {
  PublishYearBloc(InitialState<String> state) : super(state) {
    const intLengthRequired = 4;

    on<String>(
      (event, emit) {
        if (event.length == intLengthRequired) {
          emit(ValidState(event));
        } else {
          emit(InvalidState(event));
        }
      },
    );
  }
}
