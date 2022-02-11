import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app_task/bloc/authentication/authentication_bloc.dart';
import 'package:movie_app_task/data/data_source/movie_remote_data_source.dart';
import 'package:movie_app_task/data/repository/movie_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as client;

import 'bloc/movies/movie_bloc.dart';
import 'bloc/remember_me/remember_me_bloc.dart';
import 'data/data_source/authentication_data_source.dart';
import 'data/repository/configuration_repository.dart';
import 'data/repository/user_repository.dart';

GetIt getIt = GetIt.instance;

Future<void> initializeInjection() async {
  final _sharedPreference = await SharedPreferences.getInstance();

  getIt.registerLazySingleton(() => _sharedPreference);

  getIt.registerLazySingleton(() => client.Client());

  getIt.registerLazySingleton(() => const FlutterSecureStorage());

  getIt.registerLazySingleton(() => AuthenticationDataSource());
  getIt.registerLazySingleton(() => UserRepository(
      authenticationDataSource: getIt(),
      sharedPreferences: _sharedPreference,
      secureStorage: getIt()));

//Data source
  getIt.registerLazySingleton(() => MovieRemoteDataSource(getIt(), getIt()));

  //Repositories
  getIt.registerLazySingleton(() => ConfigurationRepository(getIt()));
  getIt.registerLazySingleton(() => MovieRepository(remoteDataSource: getIt()));

//blocs
  getIt.registerFactory(() => RememberMeBloc(getIt()));

  getIt.registerFactory(
    () => AuthenticationBloc(
      getIt(),
      getIt(),
    ),
  );

  getIt.registerFactory(() => MovieBloc(movieRepository: getIt()));
}
