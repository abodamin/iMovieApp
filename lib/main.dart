import 'package:flutter/material.dart';
import 'package:i_movie_app/UI/Home/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iMovieApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF2A1C40),
        scaffoldBackgroundColor: Color(0xFF2A1C40),
        appBarTheme: AppBarTheme(centerTitle: true),
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
