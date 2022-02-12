part of 'movie_crud_bloc.dart';

abstract class MovieCrudState extends Equatable {
  const MovieCrudState();

  @override
  List<Object> get props => [];
}

class MovieCrudInitial extends MovieCrudState {}

class MovieCrudLoading extends MovieCrudState {}

class MovieCrudSuccessful extends MovieCrudState {}

class MovieCrudFailed extends MovieCrudState {}
