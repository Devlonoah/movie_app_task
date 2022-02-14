import 'dart:io';

import '../data/models/movie_model.dart';

abstract class MovieBaseClass {
  ///Fetch al movies

  Future<MovieResultModel> fetchAllMovie();

  /// Create
  Future createMovie(
      {required String name, required String year, required File imageFile});

  /// Read

  /// Update
  Future updateMovie({
    required String name,
    required String year,
    required File imageFile,
  });

  ///Delete
  Future delete(String required);

  /// Find one movie by id [get details]
  ///
  ///
  Future findOneMovie(String id);
}
