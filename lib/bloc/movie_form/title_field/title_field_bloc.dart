import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../form_bloc/validation_state.dart';

part 'title_field_state.dart';

class TitleFieldBloc extends Bloc<String, ValidationState<String>> {
  final minimumTitleLength = 3;
  TitleFieldBloc(InitialState<String> initialState) : super(initialState) {
    on<String>((event, emit) {
      if (event.length >= minimumTitleLength) {
        emit(ValidState(event));
      } else {
        emit(InvalidState(event));
      }
    });
  }
}
