import 'package:movie_app_task/core/movie_base_class.dart';

class MovieLocalDataSource implements MovieBaseClass {
  @override
  Future createMovie() async {}

  @override
  Future delete() async {}

  @override
  Future getMovie() async {}

  @override
  Future updateMovie() async {}

  @override
  Future findOneMovie(String id) {
    // TODO: implement findOneMovie
    throw UnimplementedError();
  }
}
