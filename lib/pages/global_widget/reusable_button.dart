import 'package:flutter/material.dart';
import 'package:movie_app_task/theme/color.dart';

class ReusableButton extends StatelessWidget {
  const ReusableButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

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
          'LOG IN',
          style: Theme.of(context)
              .textTheme
              .button
              ?.copyWith(color: AppColor.whiteColor),
        ),
      ),
    );
  }
}
