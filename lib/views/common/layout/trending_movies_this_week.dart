
import 'package:carousel_slider/carousel_slider.dart';
import 'package:i_movie_app/app/resources.dart';
import 'package:i_movie_app/data/api_models/TrendingMoviesModel.dart';
import 'package:i_movie_app/app/imports.dart';
import 'package:i_movie_app/views/common/widgets/rounded_poster_image.dart';

import 'package:i_movie_app/views/common/shimmers/carousel_shimmer.dart';
import 'package:i_movie_app/views/details/details_page.dart';

class TrendingMoviesThisWeek extends StatelessWidget {
  final TrendingMoviesModel? data;

  const TrendingMoviesThisWeek({Key? key, this.data}) : super(key: key);

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
                autoPlay: false,
                aspectRatio: 0.8,
                enlargeCenterPage: true,
                viewportFraction: getMediaWidth(context) > 600 ? 0.5 : 0.7,
              ),
              items: List.generate(
                10,
                (index) {
                  var _path = snapshot.data?.results![index];
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
          } else if(snapshot.hasError){
            return SizedBox.shrink();
          } else {
            return CarouselShimmer();
          }
        },
      ),
    );
  }
}

class MoviePosterImage extends StatelessWidget {
  final String item;

  const MoviePosterImage({
    Key? key,
    required this.item,
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
    Key? key,
    required this.imageName,
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
