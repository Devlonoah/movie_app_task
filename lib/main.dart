import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app_task/bloc/authentication/authentication_cubit.dart';
import 'package:movie_app_task/bloc/remember_me/remember_me_cubit.dart';
import 'package:movie_app_task/pages/landing_page/landing_page.dart';
import 'package:movie_app_task/pages/login/login_page.dart';
import 'package:movie_app_task/theme/color.dart';
import 'package:movie_app_task/theme/theme.dart';

import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeInjection();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: AppColor.backgroundColor
          //color set to transperent or set your own color
          ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthenticationCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<RememberMeCubit>(),
          lazy: false,
        )
      ],
      child: MaterialApp(
        title: 'Movie_',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            // fontFamily: GoogleFonts.montserrat().fontFamily,
            scaffoldBackgroundColor: AppColor.backgroundColor,
            primaryColor: AppColor.primaryColor,
            textTheme: customTextTheme),
        routes: {
          LandingPage.id: (context) => const LandingPage(),
          LoginPage.id: (contex) => const LoginPage()
        },
        initialRoute: LoginPage.id,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
