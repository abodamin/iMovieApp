import 'package:flutter/material.dart';
import 'package:i_movie_app/App/imports.dart';
import 'package:i_movie_app/Model/assets_names.dart';
import 'package:i_movie_app/UI/Home/DetailsPage.dart';
import 'package:i_movie_app/UI/Widgets/Utils.dart';
import 'package:i_movie_app/UI/Widgets/trending_movies.dart';

class GlobalMoviesGridView extends StatelessWidget {
  final List listOfMovies;
  const GlobalMoviesGridView({Key key, @required this.listOfMovies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: getMediaHeight(context)*0.82,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.6,
        ),
        itemCount: listOfMovies?.length??0,
        itemBuilder: (context, index) {
          if(listOfMovies.isEmpty || listOfMovies == null ){
            return TrendingMovies();
          } else {
            return GestureDetector(
              onTap: () {
                navigateTo(
                  context,
                  DetailsPage(
                    id: listOfMovies[index].id.toString(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(4),
                child: Container(
                  height: get200Size(context) + get50Size(context),
                  width: getMediaWidth(context),
                  child: Image.network(
                    R.getNetworkImagePath(listOfMovies[index]?.posterPath??""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
