part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieInProgress extends MovieState {}

class MovieSuccesful extends MovieState {
  final MovieResultModel movies;
  const MovieSuccesful({
    required this.movies,
  });
}

class MovieFailed extends MovieState {}
