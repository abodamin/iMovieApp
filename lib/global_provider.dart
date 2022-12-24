import 'package:flutter/material.dart';
import 'package:i_movie_app/inject/dependency_injection.dart';
import 'package:i_movie_app/views/factory/view_model_factory.dart';
import 'package:i_movie_app/views/home/home_page_viewmodel.dart';

import 'package:provider/provider.dart';

class GlobalProvider extends StatelessWidget {
  const GlobalProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //injects all ViewModels
        Provider.value(value: getIt.get<ViewModelFactory>()),
        // Provider.value(value: getIt.get<HomePageViewModel>()),
      ],
      child: child,
    );
  }
}
