
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_movie_app/App/imports.dart';
import 'package:loading_indicator/loading_indicator.dart';

class MyLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: get60Size(context),
      child: Center(
        child: FutureBuilder(
          future: Future.delayed(Duration(seconds: 1), (){}),
          builder: (context, snapshot) {
            return SizedBox(
              height: get60Size(context),
              child: LoadingIndicator(
                indicatorType: Indicator.ballBeat,
                color: getTheme(context).accentColor,

              ),
            );
          }
        )
      ),
    );
  }
}
