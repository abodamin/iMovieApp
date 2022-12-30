import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_movie_app/app/Globals.dart';
import 'package:i_movie_app/data/api_models/MovieCastModel.dart';
import 'package:i_movie_app/data/api_models/MovieDetailsModel.dart';
import 'package:i_movie_app/data/api_models/SimilarMoviesModel.dart';
import 'package:i_movie_app/app/resources.dart';
import 'package:i_movie_app/views/common/app_navigation.dart';
import 'package:i_movie_app/views/common/layout/app_loading_widget.dart';
import 'package:i_movie_app/views/common/layout/movie_rate_bar.dart';

import 'package:i_movie_app/views/common/responsive.dart';
import 'package:i_movie_app/views/common/shimmers/trending_actors_shimmer.dart';
import 'package:i_movie_app/views/common/shimmers/trending_movies_shimmer.dart';
import 'package:i_movie_app/views/common/utils.dart';
import 'package:i_movie_app/views/common/widgets/favoriteIcon.dart';
import 'package:i_movie_app/views/common/layout/cast_card.dart';
import 'package:i_movie_app/views/common/widgets/credits_footer.dart';
import 'package:i_movie_app/views/common/widgets/global_icons.dart';

import 'package:i_movie_app/views/common/layout/trending_movies.dart';
import 'package:i_movie_app/views/common/widgets/gradient_image.dart';
import 'package:i_movie_app/views/details/details_page_data.dart';
import 'package:i_movie_app/views/details/details_page_viewmodel.dart';
import 'package:i_movie_app/views/factory/screen.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class DetailsPage extends Screen {
  final String id;

  DetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState
    extends ScreenState<DetailsPage, DetailsPageViewModel, DetailsPageData> {
  @override
  Widget buildScreen(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: Container(
          height: getMediaHeight(context),
          width: getMediaWidth(context),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  child: FutureBuilder<MovieDertailsModel>(
                      future: viewModel.getMovieDetails(widget.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // --- GradientImg --- //
                              _GradientImgSection(
                                data: snapshot.data!,
                              ),
                              // --- Rating --- //
                              MovieRateBar(
                                voteAverage: snapshot.data!.voteAverage!,
                              ),
                              // --- overview --- //
                              _OverviewSection(
                                movie: snapshot.data!,
                                viewModel: viewModel,
                              ),
                              mHeight(get20Size(context)),
                              // --- Budget Duration ReleaseData --- //
                              _BudgetDurationReleaseDateSection(
                                  data: snapshot.data),
                              mHeight(get20Size(context)),
                              // --- Genres --- //
                              _GenresSection(
                                data: snapshot.data,
                              ),
                              mHeight(get20Size(context)),
                              // --- Cast --- //
                              _CastSection(
                                movieId: widget.id,
                                viewModel: viewModel,
                              ),
                              mHeight(get20Size(context)),
                              // --- Similar Movies --- //
                              _SimilarMoviesSection(
                                movieId: widget.id,
                                viewModel: viewModel,
                              ),
                              mHeight(get80Size(context)),
                              //
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return SizedBox(
                            height: getMediaHeight(context),
                            child: Center(
                              child: Text(
                                "Something went wrong check your connection.",
                                style: getTextTheme(context).titleLarge,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        } else {
                          return AppLoadingWidget();
                        }
                      }),
                ),
              ),
              // --- Back Arrow --- //
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
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
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${title.toUpperCase() ?? "--"}",
          style: getTextTheme(context).bodyText2!.copyWith(
                color: Colors.grey,
              ),
        ),
        //
        Text(
          value ?? "--",
          style: getTextTheme(context).button!.copyWith(
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
    Key? key,
    required this.title,
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
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: getMediaHeight(context) * 1.7,
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
                  crossAxisCount: getMediaWidth(context) > 600 ? 4 : 3,
                  childAspectRatio: 0.6,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemCount:
                    data.results!.length > 18 ? 18 : data.results!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      AppNav.navigateToDetailsPage(context,
                              data.results![index].id.toString(),
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
                                data.results![index].posterPath ?? "",
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

class _GradientImgSection extends StatelessWidget {
  final MovieDertailsModel data;

  const _GradientImgSection({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: get200Size(context) + get200Size(context),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              GredientImage(
                  imageName: R.getNetworkImagePath(
                data.posterPath ?? "",
                highQuality: true,
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${data.title ?? ""}",
                  maxLines: 4,
                  style: getTextTheme(context).headline6,
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
                color: getTheme(context).accentColor, // Button color
                child: InkWell(
                  onTap: () {
                    //TODO
                    // navigateTo(
                    //   context,
                    //   ShowTrailerPage(
                    //     movieId: snapshot?.data?.id
                    //         ?.toString(),
                    //   ),
                    // );
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
    );
  }
}

class _OverviewSection extends StatelessWidget {
  final MovieDertailsModel movie;
  final DetailsPageViewModel viewModel;

  const _OverviewSection({
    Key? key,
    required this.movie,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "OVERVIEW",
                style: getTextTheme(context).caption,
              ),
              Spacer(),
              FutureBuilder<bool>(
                  future: viewModel.isMovieFavorite(movie),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return FavoriteIcon(
                        movie: movie,
                        isFavorite: snapshot.data!,
                        onStoreCallback: () async {
                          _favoriteClick(snapshot);
                        },
                      );
                    } else {
                      return FavoriteIcon(
                        movie: movie,
                        isFavorite: false,
                        onStoreCallback: () async {
                          _favoriteClick(snapshot);
                        },
                      );
                    }
                  }),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${movie.overview}",
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }

  Future<void> _favoriteClick(AsyncSnapshot<bool> snapshot) async {
    if (snapshot.data ?? false) {
      await viewModel.removeMovieFromFavorite(movie);
      print(
          "___removingMovieFromFavorite>> ${movie.title}");
    } else {
      await viewModel.saveMovieAsFavorite(movie);
      print("___saveMovieAsFavorite>> ${movie.title}");
    }
  }
}

class _BudgetDurationReleaseDateSection extends StatelessWidget {
  final MovieDertailsModel? data;
  final _currency = NumberFormat("#,##0", "en_US");

  _BudgetDurationReleaseDateSection({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: get40Size(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _TitleAndValue(
              title: "Budget",
              value: "${_currency.format(data?.budget ?? "0")}\$",
            ),
            _TitleAndValue(
              title: "Duration",
              value: "${data?.runtime ?? "0"} min",
            ),
            _TitleAndValue(
              title: "Release Date",
              value:
                  "${data?.releaseDate != null ? DateFormat('yyyy-MM-dd').format(data!.releaseDate!) : ""}",
            ),
          ],
        ),
      ),
    );
  }
}

class _GenresSection extends StatelessWidget {
  final MovieDertailsModel? data;

  const _GenresSection({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "GENRES",
            style: getTextTheme(context).bodyText2!.copyWith(
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
              data!.genres?.length ?? 0,
              (index) {
                return Genre(
                  title: "${data?.genres![index].name}",
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}

class _CastSection extends StatelessWidget {
  final String movieId;
  final DetailsPageViewModel viewModel;

  const _CastSection({Key? key, required this.movieId, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "CAST",
            style: getTextTheme(context).bodyText2!.copyWith(
                  color: Colors.grey,
                ),
          ),
        ),
        Container(
          // padding: const EdgeInsets.all(8),
          width: getMediaWidth(context),
          height: get160Size(context) + 5,
          child: FutureBuilder<MovieCastModel>(
              future: viewModel.getMovieCast(movieId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.cast?.length ?? 0,
                    itemBuilder: (context, index) {
                      return AspectRatio(
                        aspectRatio: 0.8,
                        child: CastCard(
                          imagePath:
                              "$imgBaseURLLQ${snapshot.data?.cast![index].profilePath}",
                          actorName: "${snapshot.data?.cast![index].name}",
                          bio: "${snapshot.data?.cast![index].character}",
                        ),
                      );
                    },
                  );
                } else {
                  return TrendingActorsShimmer();
                }
              }),
        ),
      ],
    );
  }
}

class _SimilarMoviesSection extends StatelessWidget {
  final String movieId;
  final DetailsPageViewModel viewModel;

  const _SimilarMoviesSection(
      {Key? key, required this.movieId, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: mHor8Vert8,
          child: Text(
            "SIMILAR MOVIES",
            style: getTextTheme(context).bodyText2!.copyWith(
                  color: Colors.grey,
                ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: FutureBuilder<SimilarMoviesModel>(
              future: viewModel.getSimilarMovies(movieId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // if there is similar movies, bring any movies.
                  if (snapshot.data?.results!.length == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Couldn't find similar movies",
                        ),
                        mHeight(5),
                        TrendingMovies(
                          viewModel: viewModel,
                        ),
                      ],
                    );
                  } else {
                    //if there is similar movies show them
                    return SimilarMovies(
                      data: snapshot.data!,
                    );
                  }
                } else if (snapshot.hasError) {
                  return SizedBox.shrink();
                } else {
                  return TrendingMoviesShimmer();
                }
              }),
        ),
      ],
    );
  }
}
