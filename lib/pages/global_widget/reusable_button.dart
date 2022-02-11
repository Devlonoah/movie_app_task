import 'package:flutter/material.dart';
import 'package:movie_app_task/theme/color.dart';

class ReusableButton extends StatelessWidget {
  const ReusableButton({
    Key? key,
    this.onPressed,
    required this.label,
  }) : super(key: key);

  final String label;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: TextButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .button
              ?.copyWith(color: AppColor.whiteColor),
        ),
      ),
    );
  }
}
