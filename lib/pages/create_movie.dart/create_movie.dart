import 'package:flutter/material.dart';
import 'package:movie_app_task/pages/global_widget/reusable_button.dart';
import 'package:movie_app_task/pages/login/login_page.dart';
import 'package:movie_app_task/theme/color.dart';
import 'package:movie_app_task/theme/constants.dart';

class CreateMoviePage extends StatelessWidget {
  static String id = "CreateMoviePage";
  const CreateMoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CreateMoviePageBody());
  }
}

class CreateMoviePageBody extends StatelessWidget {
  const CreateMoviePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kkMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kkHeightFromTop),
          Text(
            'Create a new movie',
            style: Theme.of(context)
                .textTheme
                .headline3
                ?.copyWith(color: AppColor.whiteColor),
          ),
          const SizedBox(height: 40),
          const ReusableTextField(hintText: 'Title', errorText: ''),
          const ReusableTextField(hintText: 'Publishing Year', errorText: ''),
          AspectRatio(
              aspectRatio: 1.6,
              child: Container(
                color: Colors.red,
              )),
          Row(
            children: [
              ButtonWithBorder(),
              ReusableButton(label: 'Submit'),
            ],
          )
        ],
      ),
    );
  }
}

class ButtonWithBorder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: () {}, child: Text('Cancel'));
  }
}
