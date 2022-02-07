import 'package:flutter/material.dart';
import 'package:movie_app_task/theme/color.dart';
import 'package:movie_app_task/theme/constants.dart';
import 'package:movie_app_task/theme/theme.dart';

class ReusableTextField extends StatelessWidget {
  final String hintText;
  final void Function(String)? onChanged;

  const ReusableTextField({Key? key, required this.hintText, this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kkBorderRadius),
      child: TextField(
        textAlign: TextAlign.left,
        style: customTextTheme.bodyText2?.copyWith(color: AppColor.whiteColor),
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: AppColor.inputColor,
          filled: true,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle:
              customTextTheme.subtitle2?.copyWith(color: AppColor.whiteColor),
        ),
      ),
    );
  }
}
