import 'package:i_movie_app/data/api_models/search_by_genre_result.dart';
import 'package:i_movie_app/data/api_models/search_movies_result.dart';
import 'package:i_movie_app/domain/models/category_enum.dart';
import 'package:i_movie_app/domain/repository/movies_repository.dart';
import 'package:i_movie_app/views/factory/view_model.dart';
import 'package:i_movie_app/views/search/search_page_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchPageViewModel extends ViewModel<SearchPageData> {
  final MoviesRepository _repository;

  SearchPageViewModel(this._repository) : super(SearchPageData());

  void onTextChange(String text) {
    _updateState(searchKeyword: text);

  }

  void onSearch() {
    _updateState(didStartSearching: true);
  }

  Future<SearchMovieResult> searchMovieByKeyword(searchKeyWord) async {
    return await _repository.searchForMovie(searchKeyWord);
  }

  void updateGenreIdsList() {
    _updateState(
      genreIDs: value.genreIDs,
    );
  }

  void showResults(bool showResult) {
    _updateState(showResults: showResult);
  }

  Future<SearchByGenreResult> searchByGenre(sortedGenreIDs, String year) async {
    return await _repository.searchByGenre(sortedGenreIDs, year);
  }

  ///returns genres as list of string
  String getSortedGenresIds(List<int> genreIds) {
    return genreIds.toString().replaceAll("[", "").replaceAll("]", "");
  }

  void addGenreId(int i) {
    value.genreIDs?.add(moviesGenreIDs.entries.toList().elementAt(i).value);
  }

  void _updateState({
    String? searchKeyword,
    bool? didStartSearching,
    bool? showResults,
    List<int>? genreIDs,
  }) {

    //
    String? mSearchKeyword = searchKeyword ?? value.searchKeyword;
    bool? mDidStartSearching = didStartSearching ?? value.didStartSearching;
    bool? mShowResults = showResults ?? value.showResults;
    List<int>? mGenreIDs = genreIDs ?? value.genreIDs;

    stateData = value.copyWith(
      searchKeyword: mSearchKeyword,
      didStartSearching: mDidStartSearching,
      showResults: mShowResults,
      genreIDs: mGenreIDs,
    );
  }

  void onReset() {
    showResults(false);
    _updateState(genreIDs: []);
  }
}
