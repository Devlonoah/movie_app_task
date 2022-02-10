import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_task/bloc/authentication/authentication_bloc.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<AuthenticationBloc>(context).appStarted();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationFailed) {
//navigate to test wul
        }
      },
      child: const Scaffold(
        body: AuthenticateBody(),
      ),
    );
  }
}

class AuthenticateBody extends StatelessWidget {
  const AuthenticateBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
