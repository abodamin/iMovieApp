import 'package:i_movie_app/app/imports.dart';
import 'package:i_movie_app/app/resources.dart';
import 'package:i_movie_app/data/api_models/search_by_genre_result.dart';
import 'package:i_movie_app/domain/models/category_enum.dart';
import 'package:i_movie_app/views/common/layout/global_movies_grid.dart';
import 'package:i_movie_app/views/common/widgets/adaptve_button.dart';
import 'package:i_movie_app/views/common/widgets/my_loading_widget.dart';
import 'package:i_movie_app/views/search/search_page_data.dart';
import 'package:i_movie_app/views/search/search_page_viewmodel.dart';
import 'package:provider/provider.dart';

class SearchByGenreFragment extends StatelessWidget {
  final SearchPageViewModel viewModel;

  SearchByGenreFragment({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Selector<SearchPageData, bool>(
          selector: (context, data) => data.didStartSearching,
          builder: (context, didStartSearching, _) {
            return AnimatedCrossFade(
              crossFadeState: didStartSearching
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 400),
              firstChild: _IntroSection(viewModel: viewModel),
              secondChild: _SelectGenresSection(viewModel: viewModel),
            );
          }),
    );
  }
}

///ImageView and hint text.
class _IntroSection extends StatelessWidget {
  const _IntroSection({Key? key, required this.viewModel}) : super(key: key);
  final SearchPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          width: getMediaWidth(context),
          child: Image.asset(
            R.getAssetImagePath("search_illustration.png"),
            color: Colors.transparent.withOpacity(0.7),
          ),
        ),
        GestureDetector(
          onTap: () {
            viewModel.onSearch();
          },
          child: RichText(
            text: TextSpan(
              text: 'Or search by category, ',
              style: getTextTheme(context).headline6,
              children: <TextSpan>[
                TextSpan(
                  text: ' let\'s go!',
                  style: getTextTheme(context).headline6!.copyWith(
                        color: getTheme(context).accentColor,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SelectGenresSection extends StatefulWidget {
  _SelectGenresSection({Key? key, required this.viewModel}) : super(key: key);

  final SearchPageViewModel viewModel;

  @override
  State<_SelectGenresSection> createState() => _SelectGenresSectionState();
}

// Stateful just to update the FilterChips color/style
class _SelectGenresSectionState extends State<_SelectGenresSection> {
  late SearchPageViewModel viewModel;
  final List<bool> _selectedGenres =
      List<bool>.filled(moviesGenreIDs.length, false);

  @override
  void initState() {
    viewModel = widget.viewModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<SearchPageData, bool>(
      selector: (context, data) => data.showResults,
      builder: (context, showResults, _) {
        if (showResults) {
          return Container(
            height: getMediaHeight(context),
            child: _SearchByGenreResultsSection(viewModel: viewModel),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text("Select category(s)",
                    style: getTextTheme(context)
                        .bodyText2!
                        .copyWith(color: Colors.grey)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 4,
                  runSpacing: 4,
                  children: List.generate(
                    moviesGenreIDs.length,
                    (index) {
                      return FilterChip(
                        selected: _selectedGenres[index],
                        selectedColor: getTheme(context).accentColor,
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: getTheme(context).accentColor, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text(
                          "${moviesGenreIDs.entries.elementAt(index).key}",
                        ),
                        onSelected: (bool value) {
                          _selectedGenres[index] = !_selectedGenres[index];
                          setState(() {});
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                width: getMediaWidth(context),
                child: AdaptiveButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Find Movies"),
                      mWidth(get10Size(context)),
                      Icon(Icons.search),
                    ],
                  ),
                  onPressed: () {
                    //this is forIndexed in kotlin
                    for (int i = 0; i < _selectedGenres.length; i++) {
                      if (_selectedGenres[i]) {
                        viewModel.addGenreId(i);
                      }
                    viewModel.updateGenreIdsList();
                    viewModel.showResults(true);
                    }
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class _SearchByGenreResultsSection extends StatelessWidget {
  const _SearchByGenreResultsSection({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final SearchPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Selector<SearchPageData, List<int>>(
        selector: (context, data) => data.genreIDs!,
        builder: (context, genreIds, _) {
          return FutureBuilder<SearchByGenreResult>(
            future: viewModel.searchByGenre(
              viewModel.getSortedGenresIds(genreIds),
              DateTime.now().year.toString(),
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GlobalMoviesGridView(
                  listOfMovies: snapshot.data!.results!,
                  onReset: () {
                    viewModel.onReset();
                  },
                );
              } else if (snapshot.hasError) {
                return Text("Ops, something went wrong");
              } else {
                return MyLoadingWidget();
              }
            },
          );
        });
  }
}
