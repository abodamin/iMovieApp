
import 'package:flutter/material.dart';
import 'package:i_movie_app/app/imports.dart';
import 'package:i_movie_app/views/common/responsive.dart';

class MadeByAbdullah extends StatelessWidget {
  const MadeByAbdullah({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Made with joy by ABDULLAH ♥ \n powered by TMDB.com",
        style:
        getTextTheme(context).caption!.copyWith(color: Colors.white70),
        textAlign: TextAlign.center,
      ),
    );
  }
}