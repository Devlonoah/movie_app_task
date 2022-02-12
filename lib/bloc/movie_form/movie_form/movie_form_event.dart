part of 'movie_form_bloc.dart';

class MovieFormEvent {
  const MovieFormEvent({
    this.title,
    this.publishYear,
    this.imagePath,
  });

  final ValidationState<String>? title;

  final ValidationState<String>? publishYear;
  final ValidationState<String>? imagePath;
}
