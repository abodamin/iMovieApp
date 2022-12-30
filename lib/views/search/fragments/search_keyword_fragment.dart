// import 'package:i_movie_app/app/imports.dart';
// import 'package:i_movie_app/data/api_models/search_movies_result.dart';
// import 'package:i_movie_app/views/common/layout/global_movies_grid.dart';
// import 'package:i_movie_app/views/common/widgets/my_loading_widget.dart';
//
// class SearchWithKeyword extends StatelessWidget {
//   final searchKeyWord;
//   final viewModel;
//
//   const SearchWithKeyword({Key? key, required this.searchKeyWord})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: FutureBuilder<SearchMovieResult>(
//         future: viewModel.searchforMovie(searchKeyWord ?? " "),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return GlobalMoviesGridView(
//               listOfMovies: snapshot.data?.results ?? [],
//             );
//           } else if (snapshot.hasError) {
//             return Text("Ops, something went wrong");
//           } else {
//             return MyLoadingWidget();
//           }
//         },
//       ),
//     );
//   }
// }
