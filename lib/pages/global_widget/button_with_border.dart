import 'package:flutter/material.dart';
import '../../theme/barrel.dart';

class ButtonWithBorder extends StatelessWidget {
  const ButtonWithBorder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Text('Cancel'),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        onSurface: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kkBorderRadius),
          side: const BorderSide(color: AppColor.whiteColor, width: 1.5),
        ),
      ),
    );
  }
}
