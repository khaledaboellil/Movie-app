import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/layout/MovieLayout.dart';
import 'package:movie_app/layout/cubit/movieCubit.dart';
import 'package:movie_app/layout/cubit/moviestates.dart';
import 'package:movie_app/shared/styles/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lighttheme,
            darkTheme: darktheme,
            themeMode: ThemeMode.dark,
            home: MovieLayout(),
          );

  }
}

