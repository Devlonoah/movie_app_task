abstract class MovieEvent {}

class MovieFetchedEvent extends MovieEvent {}

class MovieDeletedEvent extends MovieEvent {
  final String id;

  MovieDeletedEvent(this.id);
}
