import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_movie_app/App/Globals.dart';
import 'package:i_movie_app/UI/Home/HomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  await SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
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
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF2A1C40),
        scaffoldBackgroundColor: Color(0xFF2A1C40),
        appBarTheme: AppBarTheme(centerTitle: true),
        primarySwatch: Colors.indigo,
        accentColor: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
