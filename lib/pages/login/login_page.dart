import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../bloc/authentication/authentication_bloc.dart';
import '../../bloc/authentication/authentication_event.dart';
import '../../bloc/form_bloc/field_bloc/email_field_bloc.dart';

import '../../bloc/form_bloc/field_bloc/password_bloc.dart';
import '../../bloc/form_bloc/field_bloc/remember_checkbox_cubit.dart';
import '../../bloc/form_bloc/login_form/login_form_bloc.dart';
import '../../bloc/form_bloc/validation_state.dart';
import '../../functions/show_snackbar.dart';
import '../global_widget/barrel.dart';

import '../home/home.dart';
import 'remember_me.dart';
import '../../theme/barrel.dart';

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

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccessful) {
          navigateToHome(context);
        }

        if (state is AuthenticationFailed) {
          showSnackBar(context: context, message: 'Authentication failed');
        }
      },
      builder: (context, state) => LoadingOverlay(
        isLoading: state is AuthenticationInProgress,
        opacity: kkLoadingBackgroundOpacity,
        color: AppColor.kkLoadingBackgroundColor,
        progressIndicator: const CustomLoadingWidget(),
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

                          //Email text Input

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
                              return rememberMe(
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
                                label: "LOG IN",
                                onPressed: state is ValidState
                                    ? () {
                                        context.read<AuthenticationBloc>().add(
                                              AuthenticateWithEmailAndPassword(
                                                email: state.data.email,
                                                password: state.data.password,
                                                rememberMe:
                                                    state.data.rememberMe,
                                              ),
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

void navigateToHome(BuildContext context) =>
    Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
