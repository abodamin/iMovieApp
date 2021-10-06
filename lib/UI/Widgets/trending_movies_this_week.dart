import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:i_movie_app/App/Globals.dart';
import 'package:i_movie_app/App/api.dart';
import 'package:i_movie_app/App/colors.dart';
import 'package:i_movie_app/App/imports.dart';
import 'package:i_movie_app/Model/TrendingMoviesModel.dart';
import 'package:i_movie_app/Model/assets_names.dart';
import 'package:i_movie_app/UI/Home/DetailsPage.dart';
import 'package:i_movie_app/UI/Home/carousel_shimmer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:i_movie_app/UI/Home/trending_movies_shimmer.dart';
import 'package:progressive_image/progressive_image.dart';

class TrendingMoviesThisWeek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getMediaHeight(context) * 0.5,
      width: getMediaWidth(context),
      child: FutureBuilder<TrendingMoviesModel>(
        future: ApiClient.apiClient.getTrendingMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 0.8,
                enlargeCenterPage: true,
                viewportFraction: getMediaWidth(context) > 600 ? 0.5 : 0.7,
              ),
              items: List.generate(
                10,
                (index) {
                  var _path = snapshot.data.results[index];
                  return GestureDetector(
                    onTap: () async {
                      navigateTo(
                        context,
                        DetailsPage(
                          id: _path?.id?.toString() ?? "",
                        ),
                      );
                    },
                    child: RoundedPosterImage(
                      image: R.getNetworkImagePath(
                        _path?.posterPath ?? "",
                        highQuality: true,
                      ),
                    ),
                  );
                },
              ).toList(),
            );
          } else {
            return CarouselShimmer();
          }
        },
      ),
    );
  }
}

class RoundedPosterImage extends StatelessWidget {
  final String image;

  const RoundedPosterImage({
    Key key,
    @required this.image,
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
              imageUrl: R.getNetworkImagePath(
                image,
                highQuality: true,
              ),
              fit: BoxFit.fitHeight,
            ),
    );
  }
}

class MoviePosterImage extends StatelessWidget {
  final String item;

  const MoviePosterImage({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: get200Size(context) + get50Size(context),
      width: getMediaWidth(context),
      child: GredientImage(
        imageName: item?.toString() ?? "",
      ),
    );
  }
}

class GredientImage extends StatelessWidget {
  final String imageName;

  const GredientImage({
    Key key,
    @required this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: getMediaWidth(context),
          child: Image.network(
            imageName,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.transparent,
                primaryColor,
              ],
              stops: [0.0, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}
