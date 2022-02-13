import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_task/bloc/movies/movie_bloc.dart';
import 'package:movie_app_task/bloc/movies/movie_event.dart';
import 'package:movie_app_task/core/screen_argument.dart';
import 'package:movie_app_task/data/models/movie_model.dart';
import 'package:movie_app_task/injection.dart';
import 'package:movie_app_task/pages/create_movie.dart/create_movie.dart';
import 'package:movie_app_task/pages/edit_movie/edit_movie.dart';
import 'package:movie_app_task/pages/global_widget/reusable_button.dart';
import 'package:movie_app_task/theme/color.dart';

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
          return Center(
            child: ReusableButton(
              label: 'Retry',
              onPressed: () {
                //TODO: FIX THEESE CALL FECTH ALL MOVIES AGAIN
              },
            ),
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
          SizedBox(height: 24),
          const CustomHeader(),
          SizedBox(height: 40),
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.4,
                    crossAxisSpacing: 20),
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

class CustomHeader extends StatelessWidget {
  const CustomHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'My Movies',
          style: Theme.of(context).textTheme.headline4?.copyWith(
              color: AppColor.whiteColor,
              height: 0.85,
              textBaseline: TextBaseline.alphabetic),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.add,
            color: AppColor.whiteColor,
          ),
        ),
        const Spacer(),
        IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: const Icon(
              Icons.exit_to_app,
              color: AppColor.whiteColor,
            ))
      ],
    );
  }
}

class MovieCardWidget extends StatelessWidget {
  const MovieCardWidget({
    Key? key,
    required Movies? movie,
  })  : _movie = movie,
        super(key: key);

  final Movies? _movie;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (contex) {
            return EditMoviePage(
              movies: _movie!,
            );
          }));
        },
        child: Container(
          decoration: const BoxDecoration(
            color: AppColor.cardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: CachedNetworkImage(
                      imageUrl: _movie!.attributes.poster!.small!,
                      fit: BoxFit.cover)),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _movie!.attributes.name,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: AppColor.whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _movie!.attributes.publicationYear,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: AppColor.whiteColor,
                          ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
