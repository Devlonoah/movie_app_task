import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_task/bloc/movies/movie_bloc.dart';
import 'package:movie_app_task/bloc/movies/movie_event.dart';
import 'package:movie_app_task/data/models/movie_model.dart';

import 'package:movie_app_task/pages/create_movie.dart/create_movie.dart';
import 'package:movie_app_task/pages/global_widget/barrel.dart';

class HomePage extends StatelessWidget {
  static String id = "HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: HomePageBody(),
      ),
    );
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<MovieBloc>(context).add(MovieFetchedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieSuccesful) {
          return MovieLoadedWidget(movies: state.movies);
        }

        if (state is MovieFailed) {
          return Center(
            child: ReusableButton(
              label: 'Retry',
              onPressed: () =>
                  BlocProvider.of<MovieBloc>(context).add(MovieFetchedEvent()),
            ),
          );
        }

        return const Center(
          child: CustomLoadingWidget(),
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
    return movies.movieResult!.isEmpty
        ? _emptyMoviesData(context)
        : _notEmptyWidget();
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const CustomHeader(),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.4,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 15.0),
                itemCount: movies.movieResult!.length,
                itemBuilder: (context, index) {
                  final _movie = movies.movieResult?[index];

                  return MovieCardWidget(movie: _movie);
                }),
          ),
        ],
      ),
    );
  }

  _navigetToCreateMoviePage(BuildContext context) {
    Navigator.pushNamed(context, CreateMoviePage.id);
  }
}
