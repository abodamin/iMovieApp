import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:i_movie_app/app/imports.dart';
import 'package:i_movie_app/app/resources.dart';
import 'package:i_movie_app/data/api_models/MovieDetailsModel.dart';
import 'package:i_movie_app/data/api_models/SimilarMoviesModel.dart';
import 'package:i_movie_app/views/common/app_navigation.dart';
import 'package:i_movie_app/views/common/layout/error_page.dart';
import 'package:i_movie_app/views/common/layout/movie_rate_bar.dart';

import 'package:i_movie_app/views/common/widgets/my_loading_widget.dart';
import 'package:i_movie_app/views/details/details_page.dart';
import 'package:i_movie_app/views/factory/screen.dart';
import 'package:i_movie_app/views/favorite/favorite_page_data.dart';
import 'package:i_movie_app/views/favorite/favorite_page_viewmodel.dart';
import 'package:injectable/injectable.dart';

@injectable
class FavoriteMoviesPage extends Screen {
  const FavoriteMoviesPage({Key? key}) : super(key: key);

  @override
  _FavoriteMoviesPageState createState() => _FavoriteMoviesPageState();
}

class _FavoriteMoviesPageState extends ScreenState<FavoriteMoviesPage,
    FavoritePageViewModel, FavoritePageData> {
  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Movies"),
      ),
      body: Container(
        height: getMediaHeight(context),
        child: FutureBuilder<Set<MovieDertailsModel>>(
            future: viewModel.getFavoriteMovies(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    // ---
                    SizedBox(
                      height: getMediaHeight(context) * 0.88,
                      child: ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return _ListViewItemSection(
                              data: snapshot.data!.elementAt(index),
                              viewModel: viewModel);
                        },
                      ),
                    ),
                    //
                  ],
                );
              } else if (snapshot.hasError) {
                return ErrorPage();
              } else {
                return MyLoadingWidget();
              }
            }),
      ),
    );
  }
}

class _ListViewItemSection extends StatelessWidget {
  final MovieDertailsModel data;
  final FavoritePageViewModel viewModel;

  const _ListViewItemSection({
    Key? key,
    required this.data,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNav.navigateToDetailsPage(
          context,
          data.id.toString(),
        );
      },
      child: Container(
        height: 150,
        margin: mHor16Vert8,
        child: Row(
          children: [
            // --- Poster Image --- //
            AspectRatio(
              aspectRatio: 0.8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      R.getNetworkImagePath(
                        data.posterPath ?? "",
                        highQuality: getMediaWidth(context) > 600,
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
                      "${data.title ?? ""}",
                      maxLines: 2,
                      style: getTextTheme(context)
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    // --- rating --- //
                    MovieRateBar(
                        voteAverage: _formatVotesCount(data.voteAverage!)),
                    // --- overview --- //
                    Expanded(
                      child: AutoSizeText(
                        "${data.overview ?? ""}",
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.fade,
                        maxLines: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // --- Favorite icon --- //
            // FavoriteIcon(movie: snapshot.data.results![index]),
          ],
        ),
      ),
    );
  }

  double _formatVotesCount(double votesCount) {
    return double.parse(votesCount.toDouble().toStringAsFixed(1));
  }
}
