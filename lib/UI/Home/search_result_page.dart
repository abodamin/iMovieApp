import 'package:flutter/material.dart';
import 'package:i_movie_app/App/api.dart';
import 'package:i_movie_app/App/imports.dart';
import 'package:i_movie_app/Model/search_movies_result.dart';
import 'package:i_movie_app/UI/Widgets/MyLoadingWidget.dart';
import 'package:i_movie_app/UI/Widgets/global_movies_grid.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchKeyWord;

  TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              mHeight(get20Size(context)),
              //search textField
              Container(
                decoration: containerColorRadiusBorder(
                  Colors.black38,
                  0,
                  Colors.transparent,
                ),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "search.. .",
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15, right: 15),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: (){
                        _refreshPage(_controller.text);
                      },
                    ),
                  ),
                  onChanged: (text){
                    _refreshPage(text);
                  },
                ),
              ),
              //result ListView
              searchKeyWord == null
                  ? SizedBox.shrink()
                  : Expanded(child: _performSearch()),
            ],
          ),
        ),
      ),
    );
  }

  void _refreshPage(String text){
    setState(() {
      _performSearch();
    });
  }

  Widget _performSearch() {
    return FutureBuilder<SearchMovieResult>(
      future: ApiClient.apiClient.searchforMovie(searchKeyWord??""),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GlobalMoviesGridView(listOfMovies: snapshot?.data?.results);
        } else {
          return MyLoadingWidget();
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

