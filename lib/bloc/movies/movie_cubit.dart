import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app_task/data/models/movie_model.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitial());
}
