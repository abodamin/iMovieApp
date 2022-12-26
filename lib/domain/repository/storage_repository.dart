import 'dart:convert';
import 'dart:io';

import 'package:i_movie_app/data/api_models/MovieDetailsModel.dart';
import 'package:i_movie_app/data/local_models/local_storage_manager.dart';
import 'package:i_movie_app/data/local_models/movie_details_starage.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class StorageRepository {
  const StorageRepository();
  static const FAV_LIST = "FAV_LIST";
  static const FAV_LIST_FILE = "FAV_LIST_FILE.txt";


  // final LocalStorageManager _storageManager;
  // final Logger _logger;

  Future<void> _write(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$FAV_LIST_FILE');
    await file.writeAsString(text);
  }

  Future<String?> _read() async {
    String? text;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/$FAV_LIST_FILE');
      text = await file.readAsString();
    } catch (e) {
      print("___Couldn't read file ERROR >> $e");
    }
    return text;
  }


  Future<void> saveMovieAsFavorite(MovieDertailsModel movie) async {
    String? _favoriteMovies;

    try {
      _favoriteMovies = await getFavoriteMovies();
    } catch (e) {
      _favoriteMovies = null;
    }

    if(_favoriteMovies == null) {
      String movieStr = movieDertailsModelToJson(movie);
      var movieStorageModel = MovieStorageModel(
        favoriteMovies: [],
      );
      movieStorageModel.favoriteMovies!.add(movieStr);

      String storage = json.encode(movieStorageModel.toJson());
      _write(storage);
    } else {

      //convert file string to MovieStorageModel model
      MovieStorageModel movieStorageModel = movieStorageModelFromJson(_favoriteMovies);

      //convert movie to jsonString() to add it easily in favoriteMoviesList<String>
      String movieStr = movieDertailsModelToJson(movie);
      movieStorageModel.favoriteMovies!.add(movieStr);

      // movieStorageModel is not a String,
      // so convert it to String then save it in file.
      String storage = movieStorageModelToJson(movieStorageModel);
      _write(storage);
    }
  }

  Future<String?> getFavoriteMovies() async {
    String? text = await _read();
    return (text == null || text.isEmpty) ? null : text;
  }

  Future deleteMovieFromFavorite() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$FAV_LIST_FILE');
    file.delete();
  }

}
