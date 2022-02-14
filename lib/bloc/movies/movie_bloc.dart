import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'movie_event.dart';
import '../../data/models/movie_model.dart';
import '../../data/repository/movie_repository.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;
  MovieBloc({
    required this.movieRepository,
  }) : super(MovieInitial()) {
    on<MovieFetchedEvent>(
      (event, emit) async {
        emit(MovieInProgress());
        try {
          var result = await movieRepository.fetchAllMovie();

          emit(MovieSuccesful(movies: result));
        } catch (e) {
          emit(MovieFailed());
        }
      },
    );

    on<MovieDeletedEvent>((event, emit) {
      var currentStateMovies = (state as MovieSuccesful).movies;

      try {
        var updateStateMovies = currentStateMovies.movieResult
            ?.where((element) => element.id != event.id)
            .toList();
        movieRepository.deleteMovie(event.id);

        emit(MovieSuccesful(movies: MovieResultModel(updateStateMovies)));
      } catch (e) {
        emit(MovieSuccesful(movies: currentStateMovies));
      }
    });
  }
}
