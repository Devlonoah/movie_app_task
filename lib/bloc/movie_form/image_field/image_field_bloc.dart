import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_app_task/bloc/form_bloc/validation_state.dart';

part 'image_field_event.dart';

class ImageFieldBloc extends Bloc<ImageFieldEvent, ValidationState<String>> {
  final ImagePicker imagePicker;
  ImageFieldBloc(InitialState<String> state, this.imagePicker) : super(state) {
    on<ImageFieldEvent>((event, emit) async {
      var result = await imagePicker.pickImage(source: ImageSource.gallery);

      if (result != null) {
        emit(ValidState(result.path));
      } else {
        emit(InvalidState(''));
      }
    });
  }
}
