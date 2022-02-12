part of 'movie_crud_bloc.dart';

abstract class MovieCrudEvent extends Equatable {
  const MovieCrudEvent();

  @override
  List<Object> get props => [];
}

class MovieAddedEvent extends MovieCrudEvent {
  const MovieAddedEvent({
    required this.title,
    required this.productionYear,
    required this.imagePath,
  });

  final String title;
  final String productionYear;
  final String imagePath;
}
