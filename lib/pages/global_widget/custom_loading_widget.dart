import 'package:flutter/material.dart';
import 'package:movie_app_task/theme/color.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(100)),
      child: const Padding(
        padding: EdgeInsets.all(14.0),
        child: CircularProgressIndicator(
          color: AppColor.cardColor,
        ),
      ),
    );
  }
}
