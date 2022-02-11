import 'dart:io';

import 'package:movie_app_task/data/models/movie_model.dart';

abstract class MovieBaseClass {
  ///Fetch al movies

  Future<MovieResultModel> fetchAllMovie();

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
