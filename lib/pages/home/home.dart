import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String id = "HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePageBody(),
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _loadedWidget([]);
  }
}

Widget _loadedWidget(List list) {
  return list.isEmpty ? _emptyMovieWidget() : _listOfMoviesWidget();
}

_listOfMoviesWidget() {
  return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, state) {
        return const Text('movies');
      });
}

_emptyMovieWidget() {
  return const Center(
    child: Text('Movie is empty'),
  );
}
