import 'package:i_movie_app/app/imports.dart';
import 'package:i_movie_app/data/api_models/search_movies_result.dart';
import 'package:i_movie_app/views/common/layout/global_movies_grid.dart';
import 'package:i_movie_app/views/common/widgets/my_loading_widget.dart';
import 'package:i_movie_app/views/search/search_page_viewmodel.dart';

class SearchWithKeywordFragment extends StatelessWidget {
  const SearchWithKeywordFragment(
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
