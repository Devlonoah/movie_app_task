part of 'movie_cubit.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieInProgress extends MovieState {}

class MovieSuccesful extends MovieState {
  final List<MovieModel> movies;
  const MovieSuccesful({
    required this.movies,
  });
}

class MovieFailed extends MovieState {}
