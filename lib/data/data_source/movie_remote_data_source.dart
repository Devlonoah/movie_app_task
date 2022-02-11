import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_task/core/keys.dart';
import 'package:movie_app_task/data/models/movie_model.dart';
import 'package:movie_app_task/data/repository/configuration_repository.dart';

import '../../core/movie_base_class.dart';

class MovieRemoteDataSource implements MovieBaseClass {
  final http.Client _client;

  final FlutterSecureStorage storage;
  const MovieRemoteDataSource(this._client, this.storage);

  final baseUrl = "https://zm-movies-assignment.herokuapp.com/api";

  @override
  Future<MovieResultModel> fetchAllMovie() async {
    final jwt = await storage.read(key: AppKey.jwtToken);
    final header = {HttpHeaders.authorizationHeader: "Bearer $jwt"};

    var response = await http.get(Uri.parse(baseUrl + "/movies?populate=*"),
        headers: header);

    if (response.statusCode == 200) {
      return MovieResultModel.fromJson(response.body);
    }

    throw MovieFetchException;
  }

  @override
  Future createMovie(
      {required String name, required String year, required File file}) async {
    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + "/api/movies"));

    request.fields.addAll({'data': name, "publicationYear": year});

    request.files
        .add(await http.MultipartFile.fromPath('files.poster', file.path));

    final result = await request.send();

    final response = await http.Response.fromStream(result);

    return response;
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

  @override
  Future findOneMovie(String id) {
    // TODO: implement findOneMovie
    throw UnimplementedError();
  }
}

class MovieFetchException implements Exception {}
