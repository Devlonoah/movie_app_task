import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';

import '../../form_bloc/validation_state.dart';
import '../image_field/image_field_bloc.dart';
import '../publish_year_field/publish_year_bloc.dart';
import '../title_field/title_field_bloc.dart';

part 'movie_form_event.dart';

class MovieFormBloc
    extends Bloc<MovieFormEvent, ValidationState<MovieDetails>> {
  final TitleFieldBloc titleFieldBloc;
  final PublishYearBloc publishYearBloc;
  final ImageFieldBloc imageFieldBloc;

  late StreamSubscription titleStream;
  late StreamSubscription publishStream;
  late StreamSubscription imageStream;

  MovieFormBloc({
    required this.titleFieldBloc,
    required this.publishYearBloc,
    required this.imageFieldBloc,
  }) : super(InitialState(MovieDetails.initialState())) {
    titleStream = titleFieldBloc.stream.listen((_) {
      add(MovieFormEvent(title: _));
    });

    publishStream = publishYearBloc.stream.listen((_) {
      add(MovieFormEvent(publishYear: _));
    });

    imageStream = imageFieldBloc.stream.listen((_) {
      add(MovieFormEvent(imageFile: _));
    });

    on<MovieFormEvent>((event, emit) {
      final isValid = titleFieldBloc.state is ValidState &&
          publishYearBloc.state is ValidState &&
          imageFieldBloc.state is ValidState;

      if (isValid) {
        emit(ValidState(MovieDetails(
            title: titleFieldBloc.state.data,
            publishYear: publishYearBloc.state.data,
            imageFile: imageFieldBloc.state.data!)));
      } else {
        emit(ValidState(MovieDetails(
            title: titleFieldBloc.state.data,
            publishYear: publishYearBloc.state.data,
            imageFile: imageFieldBloc.state.data!)));
      }
    });
  }
}

class MovieDetails {
  final String title;
  final String publishYear;
  final File imageFile;
  MovieDetails({
    required this.title,
    required this.publishYear,
    required this.imageFile,
  });

  static MovieDetails initialState() {
    return MovieDetails(title: '', publishYear: '', imageFile: File(''));
  }
}
