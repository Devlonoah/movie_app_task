import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication/authentication_bloc.dart';
import 'bloc/movies/movie_bloc.dart';
import 'pages/create_movie.dart/create_movie.dart';
import 'pages/edit_movie/edit_movie.dart';
import 'pages/home/home.dart';
import 'pages/landing_page/landing_page.dart';
import 'pages/login/login_page.dart';
import 'theme/color.dart';
import 'theme/theme.dart';

import 'injection.dart';
import 'observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeInjection();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: AppColor.backgroundColor
          //color set to transperent or set your own color
          ));

  BlocOverrides.runZoned(
    () {
      // Use cubits...
    },
    blocObserver: MyBlocObserver(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => getIt<AuthenticationBloc>(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => getIt<MovieBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Movie_',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: AppColor.backgroundColor,
            primaryColor: AppColor.primaryColor,
            textTheme: customTextTheme,
            fontFamily: 'Montserrat'),
        routes: {
          LandingPage.id: (context) => const LandingPage(),
          LoginPage.id: (contex) => const LoginPage(),
          HomePage.id: (context) => const HomePage(),
          CreateMoviePage.id: (context) => const CreateMoviePage(),
          EditMoviePage.id: (context) => const EditMoviePage()
        },
        initialRoute: LandingPage.id,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
