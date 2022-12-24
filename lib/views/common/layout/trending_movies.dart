

import 'package:i_movie_app/app/imports.dart';
import 'package:i_movie_app/data/api_models/TrendingMoviesModel.dart';
import 'package:i_movie_app/views/common/shimmers/trending_movies_shimmer.dart';
import 'package:i_movie_app/views/common/layout/global_movies_grid.dart';

class TrendingMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TrendingMoviesModel>(
        future: ApiClient.apiClient.getTrendingMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: snapshot.hasData,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "Trending Movies This Week",
                      style: getTextTheme(context).caption,
                    ),
                  ),
                ),
                GlobalMoviesGridView(
                  listOfMovies: snapshot.data!.results!,
                ),
              ],
            );
          } else {
            return TrendingMoviesShimmer();
          }
        });
  }
}
