import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:i_movie_app/App/Globals.dart';
import 'package:i_movie_app/App/api.dart';
import 'package:i_movie_app/Model/MovieCastModel.dart';
import 'package:i_movie_app/Model/MovieDetailsModel.dart';
import 'package:i_movie_app/Model/SimilarMoviesModel.dart';
import 'package:i_movie_app/Model/assets_names.dart';
import 'package:i_movie_app/UI/Home/trending_actors_shimmer.dart';
import 'package:i_movie_app/UI/Home/trending_movies_shimmer.dart';
import 'package:i_movie_app/UI/Widgets/MyLoadingWidget.dart';
import 'package:i_movie_app/UI/Widgets/Responsive.dart';
import 'package:i_movie_app/UI/Widgets/Utils.dart';
import 'package:i_movie_app/UI/Widgets/cast_card.dart';
import 'package:i_movie_app/UI/Widgets/credits_footer.dart';
import 'package:i_movie_app/UI/Widgets/global_icons.dart';
import 'package:i_movie_app/UI/Widgets/trending_movies_this_week.dart';
import 'package:i_movie_app/UI/Widgets/trending_movies.dart';
import 'package:i_movie_app/UI/show_trailer.dart';
import 'package:intl/intl.dart';

class DetailsPage extends StatelessWidget {
  final String id;
  final _currency = new NumberFormat("#,##0", "en_US");

  DetailsPage({
    Key key,
    @required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: getMediaHeight(context),
          width: getMediaWidth(context),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  child: FutureBuilder<MovieDertailsModel>(
                      future: ApiClient.apiClient.getMovieDetails(id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // --- GradientImg --- //
                              Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    height: get200Size(context),
                                    child: Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        GredientImage(
                                            imageName: R.getNetworkImagePath(
                                          snapshot.data.posterPath,
                                          highQuality:
                                             true,
                                        )),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${snapshot.data.title}",
                                            maxLines: 4,
                                            style:
                                                getTextTheme(context).headline6,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -30,
                                    right: 16,
                                    child: Padding(
                                      padding: mHor16Vert8,
                                      child: ClipOval(
                                        child: Material(
                                          color: getTheme(context)
                                              .accentColor, // Button color
                                          child: InkWell(
                                            onTap: () {
                                              navigateTo(
                                                context,
                                                ShowTrailerPage(
                                                  movieId: snapshot?.data?.id
                                                      ?.toString(),
                                                ),
                                              );
                                            },
                                            child: SizedBox(
                                              child: Icon(
                                                Icons.play_arrow,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // --- Rating --- //
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                // width: get120Size(context),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("${snapshot.data.voteAverage}"),
                                    mWidth(10),
                                    Container(
                                      child: RatingBar.builder(
                                        initialRating:
                                            snapshot.data.voteAverage / 2,
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "OVERVIEW",
                                  style: getTextTheme(context).caption,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${snapshot.data.overview}",
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              mHeight(get20Size(context)),
                              // --- Budget Duration ReleaseData --- //
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: get40Size(context),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _TitleAndValue(
                                        title: "Budget",
                                        value:
                                            "${_currency.format(snapshot.data.budget)}\$",
                                      ),
                                      _TitleAndValue(
                                        title: "Duration",
                                        value: "${snapshot.data.runtime} min",
                                      ),
                                      _TitleAndValue(
                                        title: "Release Date",
                                        value:
                                            "${DateFormat('yyyy-MM-dd').format(snapshot.data.releaseDate)}",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              mHeight(get20Size(context)),
                              // --- Genres --- //
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "GENRES",
                                  style:
                                      getTextTheme(context).bodyText2.copyWith(
                                            color: Colors.grey,
                                          ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  spacing: 15,
                                  children: List.generate(
                                    snapshot.data.genres.length,
                                    (index) {
                                      return Genre(
                                        title:
                                            "${snapshot.data.genres[index].name}",
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                              mHeight(get20Size(context)),
                              // --- Cast --- //
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "CAST",
                                  style:
                                      getTextTheme(context).bodyText2.copyWith(
                                            color: Colors.grey,
                                          ),
                                ),
                              ),
                              Container(
                                // padding: const EdgeInsets.all(8),
                                width: getMediaWidth(context),
                                height: get160Size(context) + 5,
                                child: FutureBuilder<MovieCastModel>(
                                    future:
                                        ApiClient.apiClient.getMovieCast(id),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data.cast.length,
                                          itemBuilder: (context, index) {
                                            return AspectRatio(
                                              aspectRatio: 0.8,
                                              child: CastCard(
                                                imagePath:
                                                    "$imgBaseURLLQ${snapshot.data.cast[index].profilePath}",
                                                actorName:
                                                    "${snapshot.data.cast[index].name}",
                                                bio:
                                                    "${snapshot.data.cast[index].character}",
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        return TrendingActorsShimmer();
                                      }
                                    }),
                              ),
                              // --- Similar Movies --- //
                              mHeight(get20Size(context)),
                              Padding(
                                padding: mHor8Vert8,
                                child: Text(
                                  "SIMILAR MOVIES",
                                  style:
                                      getTextTheme(context).bodyText2.copyWith(
                                            color: Colors.grey,
                                          ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                child: FutureBuilder<SimilarMoviesModel>(
                                    future: ApiClient.apiClient.getSimilarMovis(
                                      snapshot.data.id.toString(),
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        // if there is similar movies, bring any movies.
                                        if (snapshot.data.results.length == 0) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Couldn't find similar movies",
                                              ),
                                              mHeight(5),
                                              TrendingMovies(),
                                            ],
                                          );
                                        } else {
                                          //if there is similar movies show them
                                          return SimilarMovies(
                                            data: snapshot.data,
                                          );
                                        }
                                      } else {
                                        return TrendingMoviesShimmer();
                                      }
                                    }),
                              ),
                              //
                            ],
                          );
                        } else {
                          return Container(
                              height: getMediaHeight(context),
                              child: Center(child: MyLoadingWidget()));
                        }
                      }),
                ),
              ),
              // --- Back Arrow --- //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: BackArrowIcon(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleAndValue extends StatelessWidget {
  final String title, value;

  const _TitleAndValue({
    Key key,
    @required this.title,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${title.toUpperCase() ?? "--"}",
          style: getTextTheme(context).bodyText2.copyWith(
                color: Colors.grey,
              ),
        ),
        //
        Text(
          value ?? "--",
          style: getTextTheme(context).button.copyWith(
                color: Colors.yellow,
              ),
        ),
      ],
    );
  }
}

class Genre extends StatelessWidget {
  final String title;

  const Genre({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: containerColorRadiusBorder(
        getTheme(context).scaffoldBackgroundColor,
        12,
        Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title ?? "--"),
      ),
    );
  }
}

class SimilarMovies extends StatelessWidget {
  final SimilarMoviesModel data;

  const SimilarMovies({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: getMediaHeight(context)*1.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 9,
              fit: FlexFit.tight,
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: getMediaWidth(context) > 600? 4: 3,
                  childAspectRatio: 0.6,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemCount: data.results.length > 18? 18: data.results.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      navigateTo(
                        context,
                        DetailsPage(
                          id: data.results[index].id.toString(),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      child: Container(
                        height: get200Size(context) + get50Size(context),
                        width: getMediaWidth(context),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              R.getNetworkImagePath(
                                data?.results[index]?.posterPath ?? "",
                                highQuality: getMediaWidth(context) > 600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Flexible(
              flex: 0,
              child: MadeByAbdullah(),
            )
          ],
        ),
      ),
    );
  }
}
