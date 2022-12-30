import 'package:i_movie_app/app/imports.dart';
import 'package:i_movie_app/views/factory/screen.dart';
import 'package:i_movie_app/views/search/fragments/search_genre_fragment.dart';
import 'package:i_movie_app/views/search/fragments/search_keyword_fragment.dart';
import 'package:i_movie_app/views/search/search_page_data.dart';
import 'package:i_movie_app/views/search/search_page_viewmodel.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';

@injectable
class SearchPage extends Screen {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState
    extends ScreenState<SearchPage, SearchPageViewModel, SearchPageData> {
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
                    //search TextField
                    _searchBarSection!,
                    //result ListView
                    (searchKeyword.isEmpty)
                        ? SearchByGenreFragment(viewModel: viewModel)
                        : SearchWithKeywordFragment(
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
