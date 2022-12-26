// import 'dart:io';
//
// import 'package:i_movie_app/data/api_models/MovieDetailsModel.dart';
// import 'package:injectable/injectable.dart';
// import 'package:logger/logger.dart';
// import 'package:path_provider/path_provider.dart';
//
// // @singleton
// class LocalStorageManager {
//   const LocalStorageManager(this._file, this._logger);
//
//   final File _file;
//   final Logger _logger;
//
//   Future _write(String text) async {
//     await _file.writeAsString(text);
//   }
//
//   Future<String?> _read() async {
//     String? text;
//     try {
//       text = await _file.readAsString();
//     } catch (e) {
//       _logger.e("Couldn't read file, e >> $e");
//     }
//     return text;
//   }
//
//   Future<void> saveMovieAsFavorite(MovieDertailsModel movie) async {
//     await _write(movie.toJson().toString());
//   }
//
//   Future<String?> getFavoriteMovies() async {
//      var fileResult = await _read();
//      return fileResult;
//   }
//
//   deleteMovieFromFavorite() {}
// }
