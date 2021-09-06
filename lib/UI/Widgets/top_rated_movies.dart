



import 'package:carousel_pro/carousel_pro.dart';
import 'package:i_movie_app/App/Globals.dart';
import 'package:i_movie_app/App/api.dart';
import 'package:i_movie_app/App/imports.dart';
import 'package:i_movie_app/Model/TopRatedMoviesModel.dart';
import 'package:i_movie_app/Model/TrendingMoviesModel.dart';
import 'package:i_movie_app/UI/Home/DetailsPage.dart';
import 'package:i_movie_app/UI/Home/HomePage.dart';
import 'package:i_movie_app/UI/Widgets/trending_movies.dart';
import 'package:shimmer/shimmer.dart';


//TODO change name to Trending movies
class TopRatedMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getMediaHeight(context)*0.6,
      width: getMediaWidth(context),
      child: FutureBuilder<TrendingMoviesModel>(
        future: ApiClient.apiClient.getTrendingMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Carousel(
              dotSize: 6.0,
              boxFit: BoxFit.fill,
              autoplay: false,
              dotIncreasedColor: Colors.yellow,
              dotBgColor: Colors.purple.withOpacity(0.0),
              images: List.generate(
                10,
                    (index) {
                  return GestureDetector(
                    onTap: () async {
                      navigateTo(
                        context,
                        DetailsPage(
                          id: snapshot.data.results[index].id.toString(),
                        ),
                      );
                    },
                    child: MoviePosterImage(
                      item:
                      imgBaseURL + snapshot.data.results[index].posterPath,
                    ),
                  );
                },
              ).toList(),
            );
          } else {
            return Shimmer.fromColors(
              baseColor: Colors.grey[400].withOpacity(0.3),
              highlightColor: Colors.grey[200].withOpacity(0.3),
              loop: 4,
              child: Container(
                height: get200Size(context) + get50Size(context),
                width: getMediaWidth(context),
                color: Colors.red,
                margin: const EdgeInsets.all(4),
              ),
            );
          }
        },
      ),
    );
  }
}