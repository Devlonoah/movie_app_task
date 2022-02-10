import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:movie_app_task/bloc/authentication/authentication_bloc.dart';
import 'package:movie_app_task/bloc/form_bloc/field_bloc/email_field_bloc.dart';

import 'package:movie_app_task/bloc/form_bloc/field_bloc/password_bloc.dart';
import 'package:movie_app_task/bloc/form_bloc/field_bloc/remember_checkbox_cubit.dart';
import 'package:movie_app_task/bloc/form_bloc/login_form/login_form_bloc.dart';
import 'package:movie_app_task/bloc/form_bloc/validation_state.dart';
import 'package:movie_app_task/data/data_source/authentication_data_source.dart';
import 'package:movie_app_task/pages/global_widget/reusable_button.dart';
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

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({Key? key}) : super(key: key);

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  late EmailFieldBloc _emailFieldBloc;

  late RememberCheckboxBloc _checkboxBloc;

  late PasswordBloc _passwordFieldBloc;

  late LoginFormBloc _loginFormBloc;

  @override
  void initState() {
    super.initState();

    _emailFieldBloc = EmailFieldBloc(InitialState(''));

    _passwordFieldBloc = PasswordBloc(InitialState(''));
    _checkboxBloc = RememberCheckboxBloc(InitialState(false));

    _loginFormBloc = LoginFormBloc(
      emailFieldBloc: _emailFieldBloc,
      passwordBloc: _passwordFieldBloc,
      rememberCheckboxBloc: _checkboxBloc,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _mq = MediaQuery.of(context);
    final authDataSource = AuthenticationDataSource();

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccessful) {
          print("oya navigate to home screen");
        }

        if (state is AuthenticationFailed) {
          print("show snackbar to display error");
        }
      },
      child: LoadingOverlay(
        isLoading: context.watch<AuthenticationBloc>().state
            is AuthenticationInProgress,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                bottom: _mq.size.height * 0.1,
                right: 0,
                left: 0,
                child: Padding(
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

                          //Email textInput

                          BlocBuilder<EmailFieldBloc, ValidationState>(
                            bloc: _emailFieldBloc,
                            builder: (context, state) {
                              return ReusableTextField(
                                hintText: 'email',
                                errorText: state is InvalidState
                                    ? "invalid email"
                                    : "",
                                onChanged: (x) {
                                  _emailFieldBloc.add(x);
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 12),

                          //Password Input
                          BlocBuilder<PasswordBloc, ValidationState>(
                            bloc: _passwordFieldBloc,
                            builder: (context, state) {
                              return ReusableTextField(
                                hintText: 'password',
                                errorText: state is InvalidState
                                    ? "Invalid password"
                                    : "",
                                onChanged: (x) async {
                                  _passwordFieldBloc.add(x);
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 24),

                          BlocBuilder<RememberCheckboxBloc,
                              ValidationState<bool>>(
                            bloc: _checkboxBloc,
                            builder: (context, state) {
                              print("checkbox value $state");
                              return _rememberMe(
                                  context: context,
                                  onTap: () => _checkboxBloc.add(!state.data),
                                  color: state is ValidState
                                      ? AppColor.primaryColor
                                      : Colors.grey.shade500);
                            },
                          ),
                          const SizedBox(height: 24),

                          //Remember me checkBox

                          BlocBuilder<LoginFormBloc,
                              ValidationState<LoginDetails>>(
                            bloc: _loginFormBloc,
                            builder: (context, state) {
                              return ReusableButton(
                                onPressed: state is ValidState
                                    ? () {
                                        context
                                            .read<AuthenticationBloc>()
                                            .login(
                                              email: state.data.email,
                                              password: state.data.password,
                                              rememberMe: state.data.rememberMe,
                                            );
                                      }
                                    : null,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const ReusableBottomCurves()
            ],
          ),
        ),
      ),
    );
  }

  // Widget inputSection(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: kkMargin),
  //     child: SingleChildScrollView(
  //       child: SizedBox(
  //         height: MediaQuery.of(context).size.height,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Center(child: _boldheader(context)),
  //             const SizedBox(height: 40),
  //             const ReusableTextField(hintText: 'email'),
  //             const SizedBox(height: 24),
  //             const ReusableTextField(hintText: 'password'),
  //             const SizedBox(height: 24),
  //             _rememberMe(context),
  //             const SizedBox(height: 24),
  //             const ReusableButton()
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Row _rememberMe(
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

class ReusableTextField extends StatelessWidget {
  final String hintText;
  final void Function(String)? onChanged;
  final String errorText;

  const ReusableTextField({
    Key? key,
    required this.hintText,
    this.onChanged,
    required this.errorText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kkBorderRadius),
      child: TextField(
        textAlign: TextAlign.left,
        style: customTextTheme.bodyText2?.copyWith(color: AppColor.whiteColor),
        onChanged: onChanged,
        decoration: InputDecoration(
          errorText: errorText,
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
