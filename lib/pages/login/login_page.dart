import 'package:flutter/material.dart';
import 'package:movie_app_task/pages/global_widget/reusable_curves.dart';

import 'package:movie_app_task/theme/color.dart';
import 'package:movie_app_task/theme/constants.dart';
import 'package:movie_app_task/theme/theme.dart';

class LoginPage extends StatelessWidget {
  static String id = "LoginPage";
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: LoginPageBody(),
    );
  }
}

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _mq = MediaQuery.of(context);
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            bottom: _mq.size.height * 0.1,
            right: 0,
            left: 0,
            child: inputSection(context),
          ),
          const ReusableBottomCurves()
        ],
      ),
    );
  }

  Widget inputSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kkMargin),
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: _boldheader(context)),
              const SizedBox(height: 40),
              const ReusableTextField(hintText: 'email'),
              const SizedBox(height: 24),
              const ReusableTextField(hintText: 'password'),
              const SizedBox(height: 24),
              _rememberMe(context),
              const SizedBox(height: 24),
              const ReusableButton()
            ],
          ),
        ),
      ),
    );
  }

  Row _rememberMe(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Material(
            color: Colors.red,
            child: InkWell(
              onTap: () {},
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

  Text _boldheader(BuildContext context) {
    return Text(
      'Sign In',
      style: Theme.of(context)
          .textTheme
          .headline2
          ?.copyWith(color: Colors.white, fontSize: 48),
    );
  }
}

class ReusableButton extends StatelessWidget {
  const ReusableButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: TextButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: () {},
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
