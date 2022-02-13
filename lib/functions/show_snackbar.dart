import 'package:flutter/material.dart';
import 'package:movie_app_task/theme/color.dart';

showSnackBar({required BuildContext context, String? message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message ?? ''),
    backgroundColor: AppColor.backgroundColor,
  ));
}
