import 'package:i_movie_app/app/imports.dart';
import 'package:i_movie_app/app/resources.dart';
import 'package:i_movie_app/data/api_models/search_by_genre_result.dart';
import 'package:i_movie_app/data/api_models/search_movies_result.dart';
import 'package:i_movie_app/domain/models/category_enum.dart';
import 'package:i_movie_app/views/common/widgets/my_loading_widget.dart';
import 'package:i_movie_app/views/common/widgets/adaptve_button.dart';
import 'package:i_movie_app/views/common/layout/global_movies_grid.dart';
import 'package:i_movie_app/views/factory/screen.dart';
import 'package:i_movie_app/views/search/search_page_data.dart';
import 'package:i_movie_app/views/search/search_page_viewmodel.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';

///
///
///
/// When I wrote this only GOD and I knew how it worked,
/// now ONLY GOD knows it.
///
/// therefore if you are trying to optimize this code and fail
/// please increase the counter as warning for next developer.
///
/// total_hrs_wasted_here: 256
///
///
///
/// *just kidding, TODO: refactor code
///
@injectable
class SearchPage extends Screen {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState
    extends ScreenState<SearchPage, SearchPageViewModel, SearchPageData> {
  @override
  void initState() {
    // viewModel.init();
    super.initState();
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Selector<SearchPageData, String>(
              selector: (context, data) => data.searchKeyword,
              shouldRebuild: (prev, next) => false,
              child: _SearchBarSection(
                viewModel: viewModel,
              ),
              builder: (context, searchKeyword, _searchBarSection) {
                return Column(
                  children: [
                    mHeight(get10Size(context)),
                    //search textField
                    _searchBarSection!,
                    //result ListView
                    (searchKeyword.isEmpty)
                        ? SearchByGenreFragment(viewModel: viewModel)
                        : SearchWithKeyword(
                            viewModel: viewModel,
                            searchKeyword: searchKeyword,
                          ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

class _SearchBarSection extends StatelessWidget {
  _SearchBarSection({Key? key, required this.viewModel}) : super(key: key);

  final SearchPageViewModel viewModel;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: containerColorRadiusBorder(
        Colors.black38,
        10,
        Colors.transparent,
      ),
      margin: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Search by name.. .",
                  disabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                ),
                onChanged: (text) {
                  viewModel.onTextChange(text);
                },
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              viewModel.onTextChange(_controller.text);
            },
          ),
        ],
      ),
    );
  }
}

class SearchWithKeyword extends StatelessWidget {
  const SearchWithKeyword(
      {Key? key, required this.viewModel, required this.searchKeyword})
      : super(key: key);

  final String searchKeyword;
  final SearchPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<SearchMovieResult>(
        future: viewModel.searchMovieByKeyword(searchKeyword),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GlobalMoviesGridView(
              listOfMovies: snapshot.data?.results ?? [],
            );
          } else if (snapshot.hasError) {
            return Text("Ops, something went wrong");
          } else {
            return MyLoadingWidget();
          }
        },
      ),
    );
  }
}

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
              secondChild: SearchByGenre(
                viewModel: viewModel,
              ),
            );
          }),
    );
  }
}

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

class SearchByGenre extends StatefulWidget {
  SearchByGenre({Key? key, required this.viewModel}) : super(key: key);

  final SearchPageViewModel viewModel;

  @override
  State<SearchByGenre> createState() => _SearchByGenreState();
}

// Stateful just to update the FilterChips color/style
class _SearchByGenreState extends State<SearchByGenre> {
  late SearchPageViewModel viewModel;
  List<int> genreIDs = [];
  List<bool> _selectedGenres = List<bool>.filled(moviesGenreIDs.length, false);

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
                        // genreIDs.add(
                        //   moviesGenreIDs.entries
                        //       .toList()
                        //       .elementAt(i)
                        //       .value,
                        // );
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
                    viewModel.showResults(false);
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
