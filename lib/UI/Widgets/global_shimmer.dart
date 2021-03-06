import 'package:flutter/material.dart';
import 'package:i_movie_app/App/colors.dart';
import 'package:i_movie_app/App/imports.dart';
import 'package:shimmer/shimmer.dart';

class GlobalShimmer extends StatelessWidget {
  final double height, width;

  const GlobalShimmer({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: Duration(seconds: 3),
      baseColor: getTheme(context).primaryColor.withOpacity(0.1),
      highlightColor: getTheme(context).primaryColorLight.withOpacity(0.1),
      loop: 10000,
      child: Container(
        height: height,
        width: width,
        color: getTheme(context).primaryColor,
      ),
    );
  }
}
