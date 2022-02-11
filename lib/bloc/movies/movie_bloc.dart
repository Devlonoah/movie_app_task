import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:movie_app_task/bloc/movies/movie_event.dart';
import 'package:movie_app_task/data/models/movie_model.dart';
import 'package:movie_app_task/data/repository/movie_repository.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;
  MovieBloc({
    required this.movieRepository,
  }) : super(MovieInitial()) {
    on<MovieFetchedEvent>(
      (event, emit) async {
        try {
          var result = await movieRepository.fetchAllMovie();

          emit(MovieSuccesful(movies: result));
        } catch (e) {
          emit(MovieFailed());
        }
      },
    );
  }
}
