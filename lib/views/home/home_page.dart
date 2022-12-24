import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:i_movie_app/app/api.dart';

import 'package:i_movie_app/app/colors.dart';
import 'package:i_movie_app/data/api_models/GenreMoviesModel.dart';
import 'package:i_movie_app/data/api_models/GenresModel.dart';
import 'package:i_movie_app/data/api_models/TrendingMoviesModel.dart';
import 'package:i_movie_app/data/api_models/TrendingPeople.dart' as tp;
import 'package:i_movie_app/app/resources.dart';
import 'package:i_movie_app/views/common/layout/global_movies_grid.dart';
import 'package:i_movie_app/views/common/layout/trending_movies.dart';
import 'package:i_movie_app/views/common/layout/trending_movies_this_week.dart';
import 'package:i_movie_app/views/common/layout/cast_card.dart';
import 'package:i_movie_app/views/common/responsive.dart';
import 'package:i_movie_app/views/common/shimmers/carousel_shimmer.dart';
import 'package:i_movie_app/views/common/shimmers/trending_movies_shimmer.dart';
import 'package:i_movie_app/views/common/widgets/rounded_poster_image.dart';
import 'package:i_movie_app/views/details/details_page.dart';

import 'package:i_movie_app/views/factory/screen.dart';
import 'package:i_movie_app/views/favorite/favorite_movies_page.dart';
import 'package:i_movie_app/views/home/home_data.dart';
import 'package:i_movie_app/views/home/home_page_viewmodel.dart';
import 'package:i_movie_app/views/search/search_result_page.dart';
import 'package:i_movie_app/views/common/shimmers/tabs_and_movies_shimmer.dart';
import 'package:i_movie_app/views/common/shimmers/trending_actors_shimmer.dart';

import 'package:i_movie_app/views/common/utils.dart';

import 'package:i_movie_app/views/common/slide_list_view.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';

@injectable
class HomePage extends Screen {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState
    extends ScreenState<HomePage, HomePageViewModel, HomeData> {
  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          R.getAssetImagePath(R.ic_app_icon_only_transparent_bg),
          height: 60,
        ),
        // title: Text(appName),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              navigateTo(context, SearchPage());
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite_border_outlined),
            onPressed: () async {
              navigateTo(context, FavoriteMoviesPage());
            },
          ),
        ],
        // leading: Image.asset(R.getAssetImagePath(R.ic_app_icon_only_transparent_bg)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: getMediaWidth(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Rated Movies Posters.
                _TrendingMoviesThisWeekSection(viewModel: viewModel),
                //TabBars
                mHeight(get20Size(context)),
                _TabsAndMoviesSection(viewModel: viewModel),
                // --- GetTrendingPersons --- //
                mHeight(get20Size(context)),
                _TrendingActorsSection(viewModel: viewModel),
                mHeight(get10Size(context)),
                // ---- Top Rated Movies ---- //
                _TrendingMoviesSection(viewModel: viewModel),
                mHeight(get100Size(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TrendingMoviesSection extends StatelessWidget {
  final HomePageViewModel viewModel;

  const _TrendingMoviesSection({Key? key, required this.viewModel})
      : super(key: key);

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
          } else if (snapshot.hasError) {
            return SizedBox.shrink();
          } else {
            return TrendingMoviesShimmer();
          }
        });
  }
}

class _TrendingMoviesThisWeekSection extends StatelessWidget {
  final HomePageViewModel viewModel;

  const _TrendingMoviesThisWeekSection({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getMediaHeight(context) * 0.5,
      width: getMediaWidth(context),
      child: FutureBuilder<TrendingMoviesModel>(
        future: viewModel.getTrendingMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider(
              options: CarouselOptions(
                autoPlay: false,
                aspectRatio: 0.8,
                enlargeCenterPage: true,
                viewportFraction: getMediaWidth(context) > 600 ? 0.5 : 0.7,
              ),
              items: List.generate(
                10,
                (index) {
                  var _path = snapshot.data?.results![index];
                  return GestureDetector(
                    onTap: () async {
                      navigateTo(
                        context,
                        DetailsPage(
                          id: _path?.id?.toString() ?? "",
                        ),
                      );
                    },
                    child: RoundedPosterImage(
                      image: R.getNetworkImagePath(
                        _path?.posterPath ?? "",
                        highQuality: true,
                      ),
                    ),
                  );
                },
              ).toList(),
            );
          } else if (snapshot.hasError) {
            return _ErrorPage();
          } else {
            return CarouselShimmer();
          }
        },
      ),
    );
  }
}

class _ErrorPage extends StatelessWidget {
  const _ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getMediaHeight(context),
      child: Center(
        child: Text(
          "Ops, something went wrong check your connection and try again :/",
          style: getTextTheme(context).titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _TabsAndMoviesSection extends StatelessWidget {
  final HomePageViewModel viewModel;

  const _TabsAndMoviesSection({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GenresModel>(
      future: viewModel.getGenres(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _TabsAndMovies(
            data: snapshot.data!,
            viewModel: viewModel,
          );
        } else if (snapshot.hasError) {
          return SizedBox.shrink();
        } else {
          return TabsAndMoviesShimmer();
        }
      },
    );
  }
}

class _TrendingActorsSection extends StatelessWidget {
  final HomePageViewModel viewModel;

  _TrendingActorsSection({Key? key, required this.viewModel}) : super(key: key);

  // final vvv = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<tp.TreindingPeopleModel>(
        future: viewModel.getTrendinPersons(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var _path = snapshot.data!.results;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Trending Actors This Week",
                    style: getTextTheme(context).caption,
                  ),
                ),
                Container(
                  height: get160Size(context) + 10,
                  child: ListView.builder(
                    itemCount: _path?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var _data = _path![index];
                      return AspectRatio(
                        aspectRatio: 0.8,
                        child: CastCard(
                          imagePath:
                              R.getNetworkImagePath(_data.profilePath ?? ""),
                          actorName: _data.name ?? "",
                          bio: "",
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return SizedBox.shrink();
          } else {
            return TrendingActorsShimmer();
          }
        });
  }
}

class _TabsAndMovies extends StatefulWidget {
  final GenresModel data;
  final HomePageViewModel viewModel;

  const _TabsAndMovies({
    Key? key,
    required this.data,
    required this.viewModel,
  }) : super(key: key);

  @override
  _TabsAndMoviesState createState() => _TabsAndMoviesState();
}

class _TabsAndMoviesState extends State<_TabsAndMovies> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int movies = 0;

  late final HomePageViewModel viewModel = widget.viewModel;


  @override
  void initState() {
    _tabController = new TabController(
      length: widget.data.genres?.length ?? 0,
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
            widget.data.genres?.length ?? 0,
            (index) {
              return Tab(
                child: Text("${widget.data.genres![index].name ?? ""}"),
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
              widget.data.genres?.length ?? 0,
              (index) {
                return FutureBuilder<GenreMoviesModel>(
                    future: viewModel.getGenreMovies(widget.data.genres![index].id!),
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
                                itemCount: snapshot.data?.results?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      navigateTo(
                                        context,
                                        DetailsPage(
                                          id: "${snapshot.data?.results![index].id ?? 0}",
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
                                            padding: const EdgeInsets.all(8.0),
                                            height: get200Size(context),
                                            child: Image.network(
                                              R.getNetworkImagePath(
                                                  snapshot.data?.results![index]
                                                          .posterPath ??
                                                      "",
                                                  highQuality:
                                                      getMediaWidth(context) >
                                                          600),
                                              fit: BoxFit.fill,
                                              width: get120Size(context),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              width: get120Size(context),
                                              child: AutoSizeText(
                                                "${snapshot.data?.results![index].title ?? ""}",
                                                maxLines: 2,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            padding: const EdgeInsets.all(8.0),
                                            // width: get120Size(context),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "${snapshot.data?.results![index].voteAverage ?? ""}"),
                                                Container(
                                                  child: RatingBar.builder(
                                                    initialRating: snapshot
                                                            .data
                                                            ?.results![index]
                                                            .voteAverage ??
                                                        0 / 2,
                                                    itemSize: 15,
                                                    minRating: 0,
                                                    maxRating: 5,
                                                    ignoreGestures: true,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0.0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
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
                      } else if(snapshot.hasError){
                        return SizedBox.shrink();
                      } else {
                        return TabsAndMoviesShimmer();
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
