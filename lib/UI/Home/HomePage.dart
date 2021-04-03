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
import 'package:i_movie_app/UI/Home/DetailsPage.dart';
import 'package:i_movie_app/UI/Widgets/MyLoadingWidget.dart';
import 'package:i_movie_app/UI/Widgets/Responsive.dart';
import 'package:i_movie_app/UI/Widgets/Utils.dart';
import 'package:i_movie_app/UI/Home/DetailsPage.dart' as details;
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
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            //
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: getMediaWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Trending Movies Image.
              TrendingMovies(),
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
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text("Trending Persons This Week"),
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
                          return TrendingPeople(
                            data: snapshot.data.results[index],
                          );
                        },
                      );
                    } else {
                      return MyLoadingWidget();
                    }
                  },
                ),
              ),
              mHeight(get30Size(context)),
              // ---- Top Rated Movies ---- //
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text("Trending Movies This Week"),
              ),
              details.TrendingMovies(),
              // Container(
              //   // height: get160Size(context),
              //   child: FutureBuilder<TrendingMoviesModel>(
              //     future: ApiClient.apiClient.getTrendingMovies(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return GridView.builder(
              //           shrinkWrap: true,
              //           physics: NeverScrollableScrollPhysics(),
              //           gridDelegate:
              //               const SliverGridDelegateWithFixedCrossAxisCount(
              //             crossAxisCount: 3,
              //             childAspectRatio: 0.6,
              //           ),
              //           itemCount: snapshot.data.results.length,
              //           itemBuilder: (context, index) {
              //             return Container(
              //               margin: const EdgeInsets.all(4),
              //               child: Container(
              //                 height: get200Size(context) + get50Size(context),
              //                 width: getMediaWidth(context),
              //                 decoration: BoxDecoration(
              //                   color: Colors.transparent,
              //                   image: DecorationImage(
              //                     fit: BoxFit.cover,
              //                     image: NetworkImage(
              //                       imgBaseURL +
              //                           snapshot.data.results[index].posterPath,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             );
              //           },
              //         );
              //       } else {
              //         return MyLoadingWidget();
              //       }
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrendingPeople extends StatelessWidget {
  final tp.Result data;

  const TrendingPeople({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
              "$imgBaseURL${data.profilePath}",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${data.name}",
              style: getTextTheme(context).button,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Trending for ${data.knownForDepartment ?? ""}",
              style: getTextTheme(context).caption,
            ),
          ),
        ],
      ),
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
          Image.asset(
            getImageAsset("ic_play2.png"),
            height: 50,
          ),
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
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                "$imageName",
              ),
            ),
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

class TrendingMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: get200Size(context) + get50Size(context),
      width: getMediaWidth(context),
      child: FutureBuilder<TopRatedMviesModel>(
        future: ApiClient.apiClient.getTopRatedMovies(),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Movies
                            Container(
                              height: get200Size(context) + get100Size(context),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.results.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      navigateTo(
                                        context,
                                        DetailsPage(
                                          id: snapshot.data.results[index].id
                                              .toString(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      // margin: const EdgeInsets.all(8),
                                      height: get100Size(context),
                                      // width: get140Size(context),
                                      // color: Colors.red,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(
                                            flex: 2,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              height: get200Size(context),
                                              // width: ,
                                              child: Image.network(
                                                "$imgBaseURL${snapshot.data.results[index].posterPath}",
                                                fit: BoxFit.fill,
                                                width: get120Size(context),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: get120Size(context),
                                                child: Text(
                                                  "${snapshot.data.results[index].title}",
                                                  maxLines: 3,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 0,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              // width: get120Size(context),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "${snapshot.data.results[index].voteAverage}"),
                                                  Container(
                                                    child: RatingBar.builder(
                                                      initialRating: snapshot
                                                              .data
                                                              .results[index]
                                                              .voteAverage /
                                                          2,
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
