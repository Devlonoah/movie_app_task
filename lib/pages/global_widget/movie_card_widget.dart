import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_task/data/models/movie_model.dart';
import 'package:movie_app_task/pages/edit_movie/edit_movie.dart';
import 'package:movie_app_task/theme/barrel.dart';

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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contex) => EditMoviePage(movies: _movie!)));
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
                      imageUrl: _movie!.attributes.poster!.url!,
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
