import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_task/bloc/authentication/authentication_bloc.dart';
import 'package:movie_app_task/bloc/authentication/authentication_event.dart';
import 'package:movie_app_task/bloc/remember_me/remember_me_bloc.dart';
import 'package:movie_app_task/bloc/remember_me/remember_me_event.dart';
import 'package:movie_app_task/injection.dart';
import 'package:movie_app_task/pages/global_widget/barrel.dart';

import 'package:movie_app_task/pages/home/home.dart';
import 'package:movie_app_task/pages/login/login_page.dart';

class LandingPage extends StatefulWidget {
  static String id = "LandingPage";
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late RememberMeBloc rememberMeCubit;

  @override
  void initState() {
    // BlocProvider.of<RememberMeCubit>(context).checkRememberMeStatus();
    super.initState();

    rememberMeCubit = getIt<RememberMeBloc>();

    rememberMeCubit.add(RememberMeStatusEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          //Remember cubit listener
          BlocListener<RememberMeBloc, RememberMeState>(
            bloc: rememberMeCubit,
            listener: (context, state) {
              Navigator.pushNamed(context, LoginPage.id);
              if (state is RememberMeInActive) {
                _navigateToLoginPage(context);
              }
              if (state is RememberMeActive) {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticateWithSavedCredential());
              }
            },
          ),

          //AuthenticationCubit listener

          BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
            if (state is AuthenticationFailed) {
              _navigateToLoginPage(context);
            }

            if (state is AuthenticationSuccessful) {
              _navigateToHome(context);
            }
          })
        ],
        child: const Center(child: CustomLoadingWidget()),
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
  }
}
