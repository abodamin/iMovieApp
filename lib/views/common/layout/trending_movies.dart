

import 'package:i_movie_app/app/imports.dart';
import 'package:i_movie_app/data/api_models/TrendingMoviesModel.dart';
import 'package:i_movie_app/views/common/shimmers/trending_movies_shimmer.dart';
import 'package:i_movie_app/views/common/layout/global_movies_grid.dart';
import 'package:i_movie_app/views/home/home_page_viewmodel.dart';


class TrendingMovies extends StatelessWidget {
  final viewModel;
  const TrendingMovies({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TrendingMoviesModel>(
        future: viewModel.getTrendingMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Trending Movies This Week",
                    style: getTextTheme(context).caption,
                  ),
                ),
                GlobalMoviesGridView(
                  listOfMovies: snapshot.data!.results!,
                ),
              ],
            );
          } else if(snapshot.hasError){
            return SizedBox.shrink();
          } else {
            return TrendingMoviesShimmer();
          }
        });
  }
}