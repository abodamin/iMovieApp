import 'package:flutter/material.dart';
import 'package:i_movie_app/views/common/responsive.dart';
import 'package:i_movie_app/views/common/widgets/global_shimmer.dart';

class TrendingMoviesShimmer extends StatelessWidget {
  const TrendingMoviesShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.6,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(4),
            child: GlobalShimmer(
              height: get200Size(context) + get50Size(context),
              width: getMediaWidth(context),
            )
          );
        },
      ),
    );
  }
}
