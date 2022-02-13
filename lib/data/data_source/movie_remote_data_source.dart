import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_task/core/keys.dart';
import 'package:movie_app_task/data/models/movie_model.dart';

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
  Future<void> createMovie({
    required String name,
    required String year,
    required File imageFile,
  }) async {
    final jwt = await storage.read(key: AppKey.jwtToken);

    var stream = http.ByteStream(imageFile.openRead());

    stream.cast();

    var length = await imageFile.length();

    var uri = Uri.parse(baseUrl + "/movies");

    var request = http.MultipartRequest('POST', uri);
    // var multiPartFile = http.MultipartFile('files.poster', stream, length,
    //     filename: imageFile.path);
    var multiPartFile =
        await http.MultipartFile.fromPath('files.poster', imageFile.path);
    request.files.add(multiPartFile);

    request.headers['authorization'] = "Bearer $jwt";
    request.headers[HttpHeaders.connectionHeader] = 'keep-alive';
    request.fields['data'] =
        """{"name": "OPenFlake", "publicationYear": 2023}""";

    var respond = await request.send();

    if (respond.statusCode != 200) {
      throw MovieFetchException();
    }
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
  Future updateMovie({
    required String name,
    required String year,
    required File imageFile,
  }) async {
    final jwt = await storage.read(key: AppKey.jwtToken);

    var stream = http.ByteStream(imageFile.openRead());

    stream.cast();

    var length = await imageFile.length();

    var uri = Uri.parse(baseUrl + "/movies");

    var request = http.MultipartRequest('POST', uri);
    // var multiPartFile = http.MultipartFile('files.poster', stream, length,
    //     filename: imageFile.path);
    var multiPartFile =
        await http.MultipartFile.fromPath('files.poster', imageFile.path);
    request.files.add(multiPartFile);

    request.headers['authorization'] = "Bearer $jwt";
    request.headers[HttpHeaders.connectionHeader] = 'keep-alive';
    request.fields['data'] = """{"name": "$name", "publicationYear": $year}""";

    var respond = await request.send();

    if (respond.statusCode != 200) {
      throw MovieUpdateException();
    }
  }

  @override
  Future findOneMovie(String id) {
    // TODO: implement findOneMovie
    throw UnimplementedError();
  }
}

class MovieFetchException implements Exception {}

class MovieCreateException implements Exception {}

class MovieUpdateException implements Exception {}
