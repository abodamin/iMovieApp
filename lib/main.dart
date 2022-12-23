import 'package:flutter/material.dart';
import 'package:i_movie_app/app/Globals.dart';
import 'package:i_movie_app/app/colors.dart';

import 'package:i_movie_app/views/common/utils.dart';
import 'package:i_movie_app/views/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUIOverlays();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      // showPerformanceOverlay: true,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF2A1C40),
        scaffoldBackgroundColor: Color(0xFF2A1C40),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          elevation: 0,
        ),
        primarySwatch: Colors.indigo,
        accentColor: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
