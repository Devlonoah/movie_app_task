import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import '../../form_bloc/validation_state.dart';

part 'image_field_event.dart';

class ImageFieldBloc extends Bloc<ImageFieldEvent, ValidationState<File?>> {
  final ImagePicker imagePicker;
  ImageFieldBloc(InitialState<File?> state, this.imagePicker) : super(state) {
    on<ImageFieldEvent>((event, emit) async {
      XFile? result = await imagePicker.pickImage(source: ImageSource.gallery);

      if (result != null) {
        emit(ValidState(File(result.path)));
      } else {
        if (state is ValidState) {
          emit(ValidState(state.data));
        }

        emit(InvalidState(File('')));
      }
    });
  }
}
