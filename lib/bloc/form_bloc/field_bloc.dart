import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_task/bloc/form_bloc/validation_state.dart';

abstract class FieldBloc<T> extends Bloc<T, ValidationState<T>> {
  FieldBloc(ValidationState<T> initialState) : super(initialState);
}
