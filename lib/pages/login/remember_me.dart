import 'package:flutter/material.dart';
import 'package:movie_app_task/theme/barrel.dart';

Row rememberMe(
    {void Function()? onTap,
    required BuildContext context,
    required Color color}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Material(
          color: color,
          child: InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                  // color: Colors.grey,
                  borderRadius: BorderRadius.circular(5)),
              width: 20,
              height: 20,
            ),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Text(
        'Remember me',
        style: Theme.of(context)
            .textTheme
            .subtitle1
            ?.copyWith(color: AppColor.whiteColor),
      ),
    ],
  );
}
