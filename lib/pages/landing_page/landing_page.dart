import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_task/bloc/remember_me/remember_me_cubit.dart';
import 'package:movie_app_task/pages/login/login_page.dart';

class LandingPage extends StatefulWidget {
  static String id = "LandingPage";
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<RememberMeCubit>(context).checkRememberMeStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<RememberMeCubit, RememberMeState>(
            listener: (context, state) {
              print('listener state: $state');
              Navigator.pushNamed(context, LoginPage.id);
              if (state is RememberMeInActive) {
                Navigator.pushNamed(context, LoginPage.id);
              }
            },
            child: const Center(
              child: Text('QWERTYPOIUY'),
            )));
  }
}
