import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:i_movie_app/App/Globals.dart';
import 'package:i_movie_app/App/api.dart';

import 'package:i_movie_app/App/colors.dart';
import 'package:i_movie_app/Model/GenreMoviesModel.dart';
import 'package:i_movie_app/Model/GenresModel.dart';
import 'package:i_movie_app/Model/TopRatedMoviesModel.dart';
import 'package:i_movie_app/Model/TrendingMoviesModel.dart';
import 'package:i_movie_app/Model/TrendingPeople.dart' as tp;
import 'package:i_movie_app/Model/assets_names.dart';
import 'package:i_movie_app/UI/Home/DetailsPage.dart';
import 'package:i_movie_app/UI/Widgets/MyLoadingWidget.dart';
import 'package:i_movie_app/UI/Widgets/Responsive.dart';
import 'package:i_movie_app/UI/Widgets/Utils.dart';
import 'package:i_movie_app/UI/Home/DetailsPage.dart' as details;
import 'package:i_movie_app/UI/Widgets/avatar_photo.dart';
import 'package:i_movie_app/UI/Widgets/top_rated_movies.dart';
import 'package:i_movie_app/UI/Widgets/trending_movies.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("iMovieApp"),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              //
            },
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FlutterLogo(
            size: 10,
            textColor: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: getMediaWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Top Rated Movies Image.
              TopRatedMovies(),
              //TabBars
              mHeight(get30Size(context)),
              FutureBuilder<GenresModel>(
                future: ApiClient.apiClient.getGenres(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    //we call API then give it the required data
                    //this is better for performance & code cleaning.
                    return TabsAndMovies(
                      data: snapshot.data,
                    );
                  } else {
                    //TODO: Shimmer
                    return MyLoadingWidget();
                  }
                },
              ),
              // --- GetTrendinPersons --- //
              mHeight(get20Size(context)),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text("Trending Actors This Week",
                  style: getTextTheme(context).caption,
                ),
              ),
              Container(
                height: get160Size(context) + 10,
                child: FutureBuilder<tp.TreindingPeopleModel>(
                  future: ApiClient.apiClient.getTrendinPersons(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.results.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var _data = snapshot.data?.results[index];
                          return AspectRatio(
                            aspectRatio: 0.8,
                            child: CastCard(
                              imagePath: R.getNetworkImagePath(
                                  _data?.profilePath ?? ""),
                              actorName: _data?.name ?? "",
                              bio: "",
                            ),
                          );
                        },
                      );
                    } else {
                      return MyLoadingWidget();
                    }
                  },
                ),
              ),
              // mHeight(get10Size(context)),
              // ---- Top Rated Movies ---- //
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Trending Movies This Week",
                  style: getTextTheme(context).caption,
                ),
              ),
              TrendingMovies(),
            ],
          ),
        ),
      ),
    );
  }
}

class TrendingActors extends StatelessWidget {
  final tp.Result data;

  const TrendingActors({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
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
          child: AvatarPhoto(
            photoPath: R.getNetworkImagePath(data.profilePath),
            height: get50Size(context),
          ),
        ),
        Text(
          "${data.name}",
          style: getTextTheme(context).button,
        ),
        AutoSizeText(
          "Trending for ${data.knownForDepartment ?? ""}",
          style: getTextTheme(context).caption,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class MoviePosterImage extends StatelessWidget {
  final item;

  const MoviePosterImage({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: get200Size(context) + get50Size(context),
      width: getMediaWidth(context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          GredientImage(
            imageName: item.toString(),
          ),
          // Image.asset(
          //   getImageAsset(R.ic_play),
          //   height: 50,
          // ),
        ],
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
                // Color(0xFF2A1C40),
                primaryColor,
              ],
              stops: [0.0, 1.0],
            ),
          ),
        )
      ],
    );
  }
}

class TabsAndMovies extends StatefulWidget {
  final GenresModel data;

  const TabsAndMovies({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  _TabsAndMoviesState createState() => _TabsAndMoviesState();
}

class _TabsAndMoviesState extends State<TabsAndMovies>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int movies = 0;

  @override
  void initState() {
    _tabController = new TabController(
      length: widget?.data?.genres?.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: secondaryColor,
          indicatorColor: secondaryColor,
          tabs: List.generate(
            widget?.data?.genres?.length,
            (index) {
              return Tab(
                child: Text("${widget?.data?.genres[index]?.name ?? ""}"),
              );
            },
          ).toList(),
          controller: _tabController,
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        // ------- //
        Container(
          height: get200Size(context) + get100Size(context),
          child: TabBarView(
            children: List.generate(
              widget.data.genres.length,
              (index) {
                return FutureBuilder<GenreMoviesModel>(
                    future: ApiClient.apiClient
                        .getGenreMovies(widget.data.genres[index].id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Movies
                            Container(
                              height: get200Size(context) + get100Size(context),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot?.data?.results?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      navigateTo(
                                        context,
                                        DetailsPage(
                                          id: "${snapshot?.data?.results[index]?.id ?? 0}",
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: get100Size(context),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            height: get200Size(context),
                                            child: Image.network(
                                              "$imgBaseURL${snapshot?.data?.results[index]?.posterPath ?? ""}",
                                              fit: BoxFit.fill,
                                              width: get120Size(context),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              width: get120Size(context),
                                              child: AutoSizeText(
                                                "${snapshot?.data?.results[index]?.title ?? ""}",
                                                maxLines: 2,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            // width: get120Size(context),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "${snapshot?.data?.results[index]?.voteAverage ?? ""}"),
                                                Container(
                                                  child: RatingBar.builder(
                                                    initialRating: snapshot
                                                            ?.data
                                                            ?.results[index]
                                                            ?.voteAverage ??
                                                        0 / 2,
                                                    itemSize: 15,
                                                    minRating: 0,
                                                    maxRating: 5,
                                                    ignoreGestures: true,
                                                    direction:
                                                        Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0.0),
                                                    itemBuilder:
                                                        (context, _) => Icon(
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
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return MyLoadingWidget();
                      }
                    });
              },
            ).toList(),
            controller: _tabController,
          ),
        ),
      ],
    );
  }
}
