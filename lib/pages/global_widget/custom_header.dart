import 'package:flutter/material.dart';
import 'package:movie_app_task/pages/create_movie.dart/create_movie.dart';
import 'package:movie_app_task/theme/barrel.dart';

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
          onPressed: () {
            //navigate to Create movie page

            Navigator.pushNamed(context, CreateMoviePage.id);
          },
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
