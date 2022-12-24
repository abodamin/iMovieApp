import 'package:flutter/material.dart';
import 'package:i_movie_app/app/Globals.dart';
import 'package:i_movie_app/app/colors.dart';
import 'package:i_movie_app/global_provider.dart';
import 'package:i_movie_app/inject/dependency_injection.dart';

import 'package:i_movie_app/views/common/utils.dart';
import 'package:i_movie_app/views/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DependencyRegisterer.setupInitDI();
  setUIOverlays();
  initializeGetIt();
  runApp(
    App(),
  );
}


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalProvider(
      child: MaterialApp(
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
        home: InitialWidget(),
      ),
    );
  }
}


// use this widget as initial widget,
// helps in future with provider.
class InitialWidget extends StatelessWidget {
  const InitialWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
