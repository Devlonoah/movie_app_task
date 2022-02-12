import 'dart:convert';
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
      return MovieResultModel.fromJson(jsonDecode(response.body));
    }

    throw MovieFetchException;
  }

  @override
  Future<void> createMovie(
      {required String name,
      required String year,
      required String imagePath}) async {
    final jwt = await storage.read(key: AppKey.jwtToken);
    http.MultipartRequest request =
        http.MultipartRequest("POST", Uri.parse(baseUrl + "/movies"));

    final body = {'data': """name":"salt", "publicationYear": 2008"""};
    request.fields.addAll(body);

    request.headers.addAll({
      HttpHeaders.authorizationHeader: "Bearer +$jwt",
      HttpHeaders.contentTypeHeader: "multipart/form-data",
    });

    print("path passed is $imagePath");

    var _image = await http.MultipartFile.fromPath('files.poster', imagePath,
        filename: 'img11');
    request.files.add(_image);

    final result = await request
        .send()
        .then((value) => print("status code : ${value.statusCode}"));

    // if (response.statusCode != 200) {
    //   throw MovieCreateException();
    // }
    // print("create movie  reason : ${response.reasonPhrase}");
    // print("create movie status code : ${response.statusCode}");
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

class MovieCreateException implements Exception {}
