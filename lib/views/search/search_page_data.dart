import 'package:i_movie_app/views/factory/state_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchPageData extends StateData {
  SearchPageData({
    this.searchKeyword = "",
    this.didStartSearching = false,
    this.showResults = false,
    this.genreIDs,
  });

  String searchKeyword = "";
  bool didStartSearching = false;
  bool showResults = false;
  List<int>? genreIDs = [];


  @override
  List<Object?> get props => [searchKeyword, didStartSearching, showResults, genreIDs];


  SearchPageData copyWith({
    String searchKeyword = "",
    bool didStartSearching = false,
    bool showResults = false,
    List<int>? genreIDs,
  }) {
    return SearchPageData(
      searchKeyword: searchKeyword,
      didStartSearching: didStartSearching,
      showResults: showResults,
      genreIDs: genreIDs ?? [],
    );
  }
}
