import 'dart:io';

abstract class MovieBaseClass {
  ///Fetch al movies

  Future fetchAllMovie();

  /// Create
  Future createMovie(
      {required String name, required String year, required File file});

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
