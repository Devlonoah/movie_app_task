part of 'movie_form_bloc.dart';

class MovieFormEvent {
  const MovieFormEvent({
    this.title,
    this.publishYear,
    this.imageFile,
  });

  final ValidationState<String>? title;

  final ValidationState<String>? publishYear;
  final ValidationState<File?>? imageFile;
}
