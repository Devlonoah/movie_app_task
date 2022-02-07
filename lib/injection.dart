import 'package:get_it/get_it.dart';
import 'package:movie_app_task/bloc/authentication/authentication_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as client;

import 'bloc/remember_me/remember_me_cubit.dart';
import 'data/data_source/authentication_data_source.dart';
import 'data/repository/configuration_repository.dart';
import 'data/repository/user_repository.dart';

GetIt getIt = GetIt.instance;

Future<void> initializeInjection() async {
  final _sharedPreference = await SharedPreferences.getInstance();

  getIt.registerLazySingleton(() => _sharedPreference);

  getIt.registerLazySingleton(() => client.Client());

  getIt.registerLazySingleton(() => AuthenticationDataSource());
  getIt.registerLazySingleton(() => UserRepository(
      authenticationDataSource: getIt(), sharedPreferences: _sharedPreference));
  //Repositories
  getIt.registerLazySingleton(() => ConfigurationRepository(getIt()));

//blocs
  getIt.registerFactory(() => RememberMeCubit(getIt()));

  getIt.registerFactory(() => AuthenticationCubit(getIt()));
}
