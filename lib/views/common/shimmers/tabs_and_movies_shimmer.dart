
import 'package:i_movie_app/app/imports.dart';
import 'package:i_movie_app/views/common/widgets/global_shimmer.dart';

class TabsAndMoviesShimmer extends StatelessWidget {
  const TabsAndMoviesShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: get200Size(context) + get50Size(context),
      child: ListView.builder(
          itemCount: 6,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: _SingleTabShimmer(),
            );
          }),
    );
  }
}

class _SingleTabShimmer extends StatelessWidget {
  const _SingleTabShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              GlobalShimmer(
                height: get30Size(context),
                width: get80Size(context) + get10Size(context),
              ),
            ],
          ),
          mHeight(10),
          Row(
            children: [
              GlobalShimmer(
                height: get100Size(context) + get50Size(context),
                width: get120Size(context),
              ),
            ],
          )
        ],
      ),
    );
  }
}
