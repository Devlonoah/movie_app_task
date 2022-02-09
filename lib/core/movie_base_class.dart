abstract class MovieBaseClass {
  /// Create
  Future createMovie();

  /// Read
  Future getMovie();

  /// Update
  Future updateMovie();

  ///Delete
  Future delete();

  /// Find one movie by id
  ///
  ///
  Future findOneMovie(String id);
}
