import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:i_movie_app/App/Globals.dart';
import 'package:i_movie_app/App/api.dart';
import 'package:i_movie_app/Model/MovieCastModel.dart';
import 'package:i_movie_app/Model/MovieDetailsModel.dart';
import 'package:i_movie_app/Model/SimilarMoviesModel.dart';
import 'package:i_movie_app/Model/TrendingMoviesModel.dart';
import 'package:i_movie_app/UI/Home/HomePage.dart';
import 'package:i_movie_app/UI/Widgets/MyLoadingWidget.dart';
import 'package:i_movie_app/UI/Widgets/Responsive.dart';
import 'package:i_movie_app/UI/Widgets/Utils.dart';
import 'package:intl/intl.dart';

class DetailsPage extends StatelessWidget {
  final String id;
  var _currency = new NumberFormat("#,##0.00", "en_US");

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
                              // --- GredientImg --- //
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    height: get200Size(context),
                                    child: Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        GredientImage(
                                          imageName:
                                              "$imgBaseURL${snapshot.data.posterPath}",
                                        ),
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
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      margin: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        getImageAsset("ic_play2.png"),
                                        height: 50,
                                      ),
                                    ),
                                  )
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
                                      TitleAndValue(
                                        title: "Budget",
                                        value:
                                            "${_currency.format(snapshot.data.budget)}\$",
                                      ),
                                      TitleAndValue(
                                        title: "Duration",
                                        value: "${snapshot.data.runtime} min",
                                      ),
                                      TitleAndValue(
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
                                      return _Genre(
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
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ActorImage(
                                                img:
                                                    "$imgBaseURL${snapshot.data.cast[index].profilePath}",
                                                title:
                                                    "${snapshot.data.cast[index].name}",
                                                subtitle:
                                                    "${snapshot.data.cast[index].character}",
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        return MyLoadingWidget();
                                      }
                                    }),
                              ),
                              // --- Similar Movies --- //
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Similar Movies".toUpperCase(),
                                  style:
                                      getTextTheme(context).bodyText2.copyWith(
                                            color: Colors.grey,
                                          ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                // height: get200Size(context),
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
                                          return SimilarMovies(
                                            data: snapshot.data,
                                          );
                                        }
                                      } else {
                                        return MyLoadingWidget();
                                      }
                                    }),
                              ),
                              //
                            ],
                          );
                        } else {
                          return MyLoadingWidget();
                        }
                      }),
                ),
              ),
              // --- Back Arrow --- //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Platform.isAndroid
                        ? Icon(Icons.arrow_back)
                        : Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleAndValue extends StatelessWidget {
  final String title, value;

  const TitleAndValue({
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

class _Genre extends StatelessWidget {
  final String title;

  const _Genre({
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

class ActorImage extends StatelessWidget {
  final String img, title, subtitle;

  const ActorImage({
    Key key,
    @required this.img,
    @required this.title,
    @required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: containerColorRadiusBorder(
            Colors.transparent,
            300,
            Colors.transparent,
          ),
          width: get80Size(context),
          height: get80Size(context),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            // "$imgBaseURL${data.profilePath}",
            "${img ?? "https://picsum.photos/200/300?random=2"}",
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${title ?? "--"}",
            style: getTextTheme(context).button,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${subtitle ?? "--"}",
            style: getTextTheme(context).caption,
          ),
        ),
      ],
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
    return Container(
      // height: get200Size(context),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.6,
        ),
        itemCount: data.results.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(4),
            child: Container(
              height: get200Size(context) + get50Size(context),
              width: getMediaWidth(context),
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "${imgBaseURL + data.results[index].posterPath}",
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TrendingMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TrendingMoviesModel>(
        future: ApiClient.apiClient.getTrendingMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              // height: get200Size(context),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.6,
                ),
                itemCount: snapshot.data.results.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    child: Container(
                      height: get200Size(context) + get50Size(context),
                      width: getMediaWidth(context),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "${imgBaseURL + snapshot.data.results[index].posterPath}",
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return MyLoadingWidget();
          }
        });
  }
}
