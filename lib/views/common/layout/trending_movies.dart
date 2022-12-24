

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
            // return Container(
            //   height: getMediaHeight(context) * 2,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Flexible(
            //         flex: 9,
            //         fit: FlexFit.tight,
            //         child: GridView.builder(
            //           shrinkWrap: true,
            //           physics: NeverScrollableScrollPhysics(),
            //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: getMediaWidth(context) > 600 ? 4 : 3,
            //             childAspectRatio: 0.6,
            //             crossAxisSpacing: 4.0,
            //             mainAxisSpacing: 4.0,
            //           ),
            //           itemCount: snapshot.data?.results?.length ?? 0,
            //           itemBuilder: (context, index) {
            //             return GestureDetector(
            //               onTap: () {
            //                 navigateTo(
            //                     context,
            //                     DetailsPage(
            //                       id: snapshot.data.results[index].id
            //                           .toString(),
            //                     ));
            //               },
            //               child: Container(
            //                 margin: const EdgeInsets.all(4),
            //                 child: Container(
            //                   height: get200Size(context) + get50Size(context),
            //                   width: getMediaWidth(context),
            //                   child: Image.network(
            //                     R.getNetworkImagePath(
            //                       snapshot.data?.results[index]?.posterPath ??
            //                           "",
            //                       highQuality: getMediaWidth(context) > 600,
            //                     ),
            //                     fit: BoxFit.cover,
            //                   ),
            //                 ),
            //               ),
            //             );
            //           },
            //         ),
            //       ),
            //       Flexible(
            //         flex: 1,
            //         child: MadeByAbdullah(),
            //       ),
            //       SizedBox(
            //         height: 50,
            //       ),
            //     ],
            //   ),
            // );
          } else {
            return TrendingMoviesShimmer();
          }
        });
  }
}
