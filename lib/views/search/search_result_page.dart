import 'package:i_movie_app/app/imports.dart';
import 'package:i_movie_app/app/resources.dart';
import 'package:i_movie_app/data/api_models/search_by_genre_result.dart';
import 'package:i_movie_app/data/api_models/search_movies_result.dart';
import 'package:i_movie_app/domain/models/category_enum.dart';
import 'package:i_movie_app/views/common/widgets/my_loading_widget.dart';
import 'package:i_movie_app/views/common/widgets/adaptve_button.dart';
import 'package:i_movie_app/views/common/layout/global_movies_grid.dart';



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
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchKeyWord = "";
  late TextEditingController _controller;

  @override
  void initState() {
    _searchKeyWord = "";
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              mHeight(get10Size(context)),
              //search textField
              Container(
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
                            _refreshPage(text);
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _refreshPage(_controller.text);
                      },
                    ),
                  ],
                ),
              ),
              //result ListView
              // (_searchKeyWord == null || _searchKeyWord.isEmpty)
              //     ?
              // SearchByGenreFragment(),
              //     :
          SearchWithKeyword(searchKeyWord: _searchKeyWord),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _refreshPage(String text) {
    setState(() {
      _searchKeyWord = text;
      SearchWithKeyword(searchKeyWord: text);
    });
  }
}

class SearchWithKeyword extends StatelessWidget {
  final searchKeyWord;

  const SearchWithKeyword({Key? key, required this.searchKeyWord})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<SearchMovieResult>(
        future: ApiClient.apiClient.searchforMovie(searchKeyWord ?? " "),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GlobalMoviesGridView(
                listOfMovies: snapshot?.data?.results ?? []);
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

class SearchByGenreFragment extends StatefulWidget {
  const SearchByGenreFragment({Key? key}) : super(key: key);

  @override
  _SearchByGenreFragmentState createState() => _SearchByGenreFragmentState();
}

class _SearchByGenreFragmentState extends State<SearchByGenreFragment> {
  bool _didStartSearching = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedCrossFade(
        crossFadeState: _didStartSearching
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 400),
        firstChild: _searchByGenreIntro(),
        secondChild: SearchByGenre(),
      ),
    );
  }

  Widget _searchByGenreIntro() {
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
            setState(() {
              _didStartSearching = true;
            });
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
  const SearchByGenre({Key? key}) : super(key: key);

  @override
  _SearchByGenreState createState() => _SearchByGenreState();
}

class _SearchByGenreState extends State<SearchByGenre> {
  bool _showResults = false;
  List<int> genreIDs = [];
  List<bool> _selectedGenres = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    return _showResults
        ? Container(
            height: getMediaHeight(context),
            child: _performSearchByGenre(genreIDs),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text("Select category(s)",
                    style: getTextTheme(context)
                        .bodyText2
                        !.copyWith(color: Colors.grey)),
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
                          side: BorderSide(color: getTheme(context).accentColor, width: 1),
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
                    for (int i = 0; i < _selectedGenres.length; i++) {
                      if (_selectedGenres[i]) {
                        //don't even try to get it.
                        genreIDs.add(
                          moviesGenreIDs.entries.toList().elementAt(i).value,
                        );
                      }
                      setState(() {
                        _showResults = true;
                      });
                    }
                  },
                ),
              ),
            ],
          );
  }


  _resetSearchResults(){
    setState(() {
      _showResults = false;
    });
  }

  Widget _performSearchByGenre(List genreIDs) {
    String _sortedGenreIDs =
        genreIDs.toString().replaceAll("[", "").replaceAll("]", "");

    return FutureBuilder<SearchByGenreResult>(
      future: ApiClient.apiClient
          .searchByGenre(_sortedGenreIDs, DateTime.now().year.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GlobalMoviesGridView(
            listOfMovies: snapshot.data!.results!,
            onReset: () {
              _resetSearchResults();
            },
          );
        } else if (snapshot.hasError) {
          return Text("Ops, something went wrong");
        } else {
          return MyLoadingWidget();
        }
      },
    );
  }
}
