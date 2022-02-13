import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app_task/data/repository/movie_repository.dart';

part 'movie_crud_event.dart';
part 'movie_crud_state.dart';

class MovieCrudBloc extends Bloc<MovieCrudEvent, MovieCrudState> {
  final MovieRepository movieRepository;
  MovieCrudBloc({required this.movieRepository}) : super(MovieCrudInitial()) {
    on<MovieAddedEvent>((event, emit) async {
      emit(MovieCrudLoading());
      try {
        var result = await movieRepository.createMovie(
          name: event.title,
          year: event.productionYear,
          imageFile: event.imagePath,
        );

        emit(MovieCrudSuccessful());
      } catch (e) {
        emit(MovieCrudFailed());
      }
    });
  }
}
