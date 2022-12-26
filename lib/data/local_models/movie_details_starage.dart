import 'dart:convert';

import 'package:i_movie_app/data/api_models/MovieDetailsModel.dart';

MovieStorageModel movieStorageModelFromJson(String str) =>
    MovieStorageModel.fromJson(json.decode(str));

String movieStorageModelToJson(MovieStorageModel data) =>
    json.encode(data.toJson());

class MovieStorageModel {
  MovieStorageModel({this.favoriteMovies});

  final List<String>? favoriteMovies;

  factory MovieStorageModel.fromJson(Map<String, dynamic> json) {
    return MovieStorageModel(
      favoriteMovies: List<String>.from(json["favoriteMovies"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "favoriteMovies": favoriteMovies == null ? null : favoriteMovies,
      };
}
//
//
// class Movie {
//   final int? id;
//   final String? title;
//   final String? overview;
//   final int? voteCount;
//   final String? posterPath;
//
//   Movie({
//     required this.id,
//     required this.title,
//     required this.overview,
//     required this.voteCount,
//     required this.posterPath
//   });
//
//   factory Movie.convert(MovieDertailsModel model){
//     return Movie(
//         id: model.id,
//         title: model.title,
//         overview: model.overview,
//         voteCount: model.voteCount,
//         posterPath: model.posterPath);
//   }
// }
