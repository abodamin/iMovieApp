import 'package:flutter/material.dart';
import 'package:i_movie_app/UI/Widgets/Responsive.dart';
import 'package:i_movie_app/UI/Widgets/Utils.dart';
import 'package:i_movie_app/UI/Widgets/global_shimmer.dart';

class TrendingActorsShimmer extends StatelessWidget {
  const TrendingActorsShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      scrollDirection: Axis.horizontal,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, snapshot) {
        return AspectRatio(
          aspectRatio: 0.8,
          child: CastCardShimmer(),
        );
      }
    );
  }
}

class CastCardShimmer extends StatelessWidget {
  const CastCardShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: containerColorRadiusBorder(
            Colors.transparent,
            300,
            Colors.transparent,
          ),
          width: get80Size(context),
          height: get80Size(context),
          clipBehavior: Clip.antiAlias,
          child: GlobalShimmer(
            width: get80Size(context),
            height: get80Size(context),
          ),
        ),
        GlobalShimmer(
          height: get20Size(context),
          width: get60Size(context),
        ),
        GlobalShimmer(
          height: get40Size(context),
          width: get80Size(context),
        ),
      ],
    );
  }
}
