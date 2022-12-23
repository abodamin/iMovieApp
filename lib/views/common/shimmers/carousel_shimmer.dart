import 'package:i_movie_app/app/imports.dart';
import 'package:i_movie_app/views/common/widgets/global_shimmer.dart';

class CarouselShimmer extends StatelessWidget {
  const CarouselShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(40, 20, 40, 10),
      width: getMediaWidth(context)*0.7,
      decoration: containerColorRadiusBorder(
        Colors.transparent,
        40,
        Colors.transparent,
      ),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 0.9,
        child: GlobalShimmer(
          height: get200Size(context),
          width: getMediaWidth(context)*0.7,
        ),
      ),
    );
  }
}
