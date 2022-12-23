
import 'package:i_movie_app/app/imports.dart';
import 'package:i_movie_app/app/resources.dart';
import 'package:i_movie_app/views/details/DetailsPage.dart';

import 'package:i_movie_app/views/common/widgets/credits_footer.dart';
import 'package:i_movie_app/views/common/layout/trending_movies.dart';


///returns list of movies in gridview only.
class GlobalMoviesGridView extends StatelessWidget {
  final List listOfMovies;
  final  Function onReset;

  const GlobalMoviesGridView({Key key, @required this.listOfMovies, this.onReset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: getMediaHeight(context) * 1.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: this.onReset??false,
              child: GestureDetector(
                onTap: this.onReset,
                child: Container(
                  padding: mHor16Vert8,
                  alignment: Alignment.topLeft,
                  child: Text("RESET", style: getTextTheme(context).caption.copyWith(color: getTheme(context).accentColor),),
                ),
              ),
            ),
            Flexible(
              flex: 9,
              fit: FlexFit.tight,
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.6,
                ),
                itemCount: listOfMovies.length > 18 ? 18 : listOfMovies.length,
                itemBuilder: (context, index) {
                  if (listOfMovies.isEmpty || listOfMovies == null) {
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
                            R.getNetworkImagePath(
                                listOfMovies[index]?.posterPath ?? ""),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            Flexible(
              flex: 0,
              child: MadeByAbdullah(),
            ),
          ],
        ),
      ),
    );
  }
}
