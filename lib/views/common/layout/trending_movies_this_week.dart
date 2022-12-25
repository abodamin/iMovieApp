//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:i_movie_app/app/resources.dart';
// import 'package:i_movie_app/data/api_models/TrendingMoviesModel.dart';
// import 'package:i_movie_app/app/imports.dart';
// import 'package:i_movie_app/views/common/widgets/rounded_poster_image.dart';
//
// import 'package:i_movie_app/views/common/shimmers/carousel_shimmer.dart';
// import 'package:i_movie_app/views/details/details_page.dart';
//
// class TrendingMoviesThisWeek extends StatelessWidget {
//   final TrendingMoviesModel? data;
//
//   const TrendingMoviesThisWeek({Key? key, this.data}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: getMediaHeight(context) * 0.5,
//       width: getMediaWidth(context),
//       child: FutureBuilder<TrendingMoviesModel>(
//         future: ApiClient.apiClient.getTrendingMovies(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return CarouselSlider(
//               options: CarouselOptions(
//                 autoPlay: false,
//                 aspectRatio: 0.8,
//                 enlargeCenterPage: true,
//                 viewportFraction: getMediaWidth(context) > 600 ? 0.5 : 0.7,
//               ),
//               items: List.generate(
//                 10,
//                 (index) {
//                   var _path = snapshot.data?.results![index];
//                   return GestureDetector(
//                     onTap: () async {
//                       navigateTo(
//                         context,
//                         DetailsPage(
//                           id: _path?.id?.toString() ?? "",
//                         ),
//                       );
//                     },
//                     child: RoundedPosterImage(
//                       image: R.getNetworkImagePath(
//                         _path?.posterPath ?? "",
//                         highQuality: true,
//                       ),
//                     ),
//                   );
//                 },
//               ).toList(),
//             );
//           } else if(snapshot.hasError){
//             return SizedBox.shrink();
//           } else {
//             return CarouselShimmer();
//           }
//         },
//       ),
//     );
//   }
// }
