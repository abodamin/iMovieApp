import 'package:flutter/material.dart';
import 'package:i_movie_app/App/Globals.dart';
import 'package:i_movie_app/App/api.dart';
import 'package:i_movie_app/App/imports.dart';
import 'package:i_movie_app/Model/TrendingMoviesModel.dart';
import 'package:i_movie_app/Model/assets_names.dart';
import 'package:i_movie_app/UI/Home/DetailsPage.dart';
import 'package:i_movie_app/UI/Home/trending_movies_shimmer.dart';
import 'package:i_movie_app/UI/Widgets/MyLoadingWidget.dart';
import 'package:i_movie_app/UI/Widgets/Responsive.dart';
import 'package:i_movie_app/UI/Widgets/credits_footer.dart';
import 'package:i_movie_app/UI/Widgets/global_movies_grid.dart';

class TrendingMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TrendingMoviesModel>(
        future: ApiClient.apiClient.getTrendingMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GlobalMoviesGridView(listOfMovies: snapshot.data.results);
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
