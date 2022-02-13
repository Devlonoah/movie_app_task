import 'package:flutter/material.dart';
import 'package:movie_app_task/theme/barrel.dart';

class ReusableTextField extends StatelessWidget {
  final String hintText;
  final void Function(String)? onChanged;
  final String errorText;
  final bool readOnly;
  final TextEditingController? textEditingController;
  final TextInputType inputType;
  const ReusableTextField({
    Key? key,
    required this.hintText,
    this.onChanged,
    required this.errorText,
    this.readOnly = false,
    this.inputType = TextInputType.name,
    this.textEditingController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Center(
        child: TextField(
          controller: textEditingController,
          keyboardType: inputType,
          readOnly: readOnly,
          textAlign: TextAlign.left,
          style:
              customTextTheme.bodyText2?.copyWith(color: AppColor.whiteColor),
          onChanged: onChanged,
          expands: true,
          minLines: null,
          maxLines: null,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(12),
            errorText: errorText,
            fillColor: AppColor.inputColor,
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(kkBorderRadius)),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: hintText,
            hintStyle:
                customTextTheme.subtitle2?.copyWith(color: AppColor.whiteColor),
          ),
        ),
      ),
    );
  }
}









// import 'package:flutter/material.dart';
// import 'package:movie_app_task/theme/color.dart';
// import 'package:movie_app_task/theme/constants.dart';
// import 'package:movie_app_task/theme/theme.dart';

// class ReusableTextField extends StatelessWidget {
//   final String hintText;
//   final void Function(String)? onChanged;

//   const ReusableTextField({Key? key, required this.hintText, this.onChanged})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(kkBorderRadius),
//       child: TextField(
//         textAlign: TextAlign.left,
//         style: customTextTheme.bodyText2?.copyWith(color: AppColor.whiteColor),
//         onChanged: onChanged,
//         decoration: InputDecoration(
//           fillColor: AppColor.inputColor,
//           filled: true,
//           border: InputBorder.none,
//           hintText: hintText,
//           hintStyle:
//               customTextTheme.subtitle2?.copyWith(color: AppColor.whiteColor),
//         ),
//       ),
//     );
//   }
// }
