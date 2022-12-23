import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:i_movie_app/App/api.dart';
import 'package:i_movie_app/App/imports.dart';
import 'package:i_movie_app/Model/SimilarMoviesModel.dart';
import 'package:i_movie_app/Model/assets_names.dart';
import 'package:i_movie_app/UI/Home/DetailsPage.dart';
import 'package:i_movie_app/UI/Widgets/MyLoadingWidget.dart';
import 'package:i_movie_app/UI/Widgets/_FavoriteIcon.dart';

class FavoriteMoviesPage extends StatelessWidget {
  const FavoriteMoviesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Movies"),
      ),
      body: Container(
        height: getMediaHeight(context),
        child: FutureBuilder<SimilarMoviesModel>(
            future: ApiClient.apiClient.getSimilarMovis(500.toString()),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Column(
                      children: [
                        // ---
                        SizedBox(
                          height: getMediaHeight(context) * 0.88,
                          child: ListView.builder(
                              itemCount: snapshot.data.results.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    navigateTo(
                                      context,
                                      DetailsPage(
                                        id: snapshot.data.results[index].id.toString(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 150,
                                    margin: mHor16Vert8,
                                    child: Row(
                                      children: [
                                        // ---Poster Image ---
                                        AspectRatio(
                                          aspectRatio: 0.8,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  R.getNetworkImagePath(
                                                    snapshot.data.results[index]
                                                            .posterPath ??
                                                        "",
                                                    highQuality:
                                                        getMediaWidth(context) >
                                                            600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // --- Title and others ---
                                        Expanded(
                                          child: Padding(
                                            padding: mHor16Vert8,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // --- Title ---
                                                AutoSizeText(
                                                  "${snapshot?.data?.results[index]?.title ?? ""}",
                                                  maxLines: 2,
                                                  style: getTextTheme(context).titleMedium.copyWith(fontWeight: FontWeight.bold),
                                                ),
                                                // --- rating --- //

                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          "${snapshot?.data?.results[index]?.voteAverage.toStringAsFixed(1) ?? ""}"),
                                                      mWidth(10),
                                                      Container(
                                                        child: RatingBar.builder(
                                                          initialRating:
                                                          snapshot.data.results[index].voteAverage / 2,
                                                          itemSize: 15,
                                                          minRating: 0,
                                                          maxRating: 5,
                                                          ignoreGestures: true,
                                                          direction: Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemPadding: EdgeInsets.symmetric(
                                                              horizontal: 0.0),
                                                          itemBuilder: (context, _) => Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          onRatingUpdate: (rating) {
                                                            print(rating);
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // --- overview --- //
                                                Expanded(
                                                  child: AutoSizeText(
                                                    "${snapshot?.data?.results[index]?.overview ?? ""}",
                                                    textAlign:
                                                        TextAlign.justify,
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // --- Favorite icon --- //
                                        // FavoriteIcon(movie: snapshot.data.results[index]),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        //
                      ],
                    )
                  : MyLoadingWidget();
            }),
      ),
    );
  }
}
