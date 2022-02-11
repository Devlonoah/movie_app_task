import 'package:movie_app_task/data/data_source/movie_remote_data_source.dart';
import 'package:movie_app_task/data/models/movie_model.dart';

class MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepository({required this.remoteDataSource});

  //fetch all movies

  Future<MovieResultModel> fetchAllMovie() async {
    var result = remoteDataSource.fetchAllMovie();

    return result;
  }

  //create

  //update

  //delete

  //find_one
}
