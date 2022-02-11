import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_task/bloc/movies/movie_bloc.dart';
import 'package:movie_app_task/bloc/movies/movie_event.dart';
import 'package:movie_app_task/data/models/movie_model.dart';
import 'package:movie_app_task/injection.dart';
import 'package:movie_app_task/pages/create_movie.dart/create_movie.dart';
import 'package:movie_app_task/pages/global_widget/reusable_button.dart';

class HomePage extends StatelessWidget {
  static String id = "HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePageBody(),
    );
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  late MovieBloc _movieBloc;

  @override
  void initState() {
    super.initState();

    _movieBloc = getIt<MovieBloc>();

    _movieBloc.add(MovieFetchedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      bloc: _movieBloc,
      builder: (context, state) {
        if (state is MovieSuccesful) {
          return MovieLoadedWidget(movies: state.movies);
        }

        if (state is MovieFailed) {
          return const Center(
            child: Text('Failed to fetch movies'),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class MovieLoadedWidget extends StatelessWidget {
  final MovieResultModel movies;

  const MovieLoadedWidget({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return movies.data.isEmpty ? _emptyMoviesData(context) : _notEmptyWidget();
  }

  _emptyMoviesData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Your movie list is empty",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline3
                ?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 30),
          ReusableButton(
            label: 'Add Video',
            onPressed: () => _navigetToCreateMoviePage(context),
          ),
        ],
      ),
    );
  }

  _notEmptyWidget() {
    return ListView.builder(
        itemCount: movies.data.length,
        itemBuilder: (context, index) {
          return const CircleAvatar();
        });
  }

  _navigetToCreateMoviePage(BuildContext context) {
    Navigator.pushNamed(context, CreateMoviePage.id);
  }
}
