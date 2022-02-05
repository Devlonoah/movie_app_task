import 'package:http/http.dart' as http;

import '../../core/movie_base_class.dart';

class MovieRemoteDataSource implements MovieBaseClass {
  final http.Client _client;

  const MovieRemoteDataSource(this._client);

  @override
  Future createMovie() {
    // TODO: implement createMovie
    throw UnimplementedError();
  }

  @override
  Future delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future getMovie() {
    // TODO: implement getMovie
    throw UnimplementedError();
  }

  @override
  Future updateMovie() {
    // TODO: implement updateMovie
    throw UnimplementedError();
  }
}
