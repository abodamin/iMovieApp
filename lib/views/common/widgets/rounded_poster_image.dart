
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:i_movie_app/app/resources.dart';
import 'package:i_movie_app/app/imports.dart';
import 'package:i_movie_app/views/common/shimmers/carousel_shimmer.dart';

class RoundedPosterImage extends StatelessWidget {
  final String image;

  const RoundedPosterImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: containerColorRadiusBorder(
        Colors.transparent,
        20,
        Colors.transparent,
      ),
      clipBehavior: Clip.antiAlias,
      child: kIsWeb
          ? Image.network(
              R.getNetworkImagePath(image, highQuality: true),
            )
          : CachedNetworkImage(
              placeholder: (context, url) => Container(
                child: CarouselShimmer(),
              ),
              errorWidget: (context, url, _){
                return Container(
                  height: 100,
                  width: 100,
                  color: Colors.red,
                );
              },
              imageUrl: R.getNetworkImagePath(
                image,
                highQuality: true,
              ),
              fit: BoxFit.fitHeight,
            ),
    );
  }
}