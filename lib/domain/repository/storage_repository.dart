import 'dart:io';

import 'package:i_movie_app/data/api_models/MovieDetailsModel.dart';
import 'package:i_movie_app/data/local_models/movie_details_starage.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@singleton
class StorageRepository {
  const StorageRepository();
  static const FAV_LIST = "FAV_LIST";
  static const FAV_LIST_FILE = "FAV_LIST_FILE.txt";

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


  ///
  ///
  ///
  /// Movies are stored as JSON in .txt file,  for simple access and fast reading.
  ///
  /// to explain in short, we always map movie object to a JSON string,
  /// then add that string to List<String> called [favoriteMovies] in  [MovieStorageModel]
  ///
  /// finally map the object of [MovieStorageModel] to JSON String then store it in file.
  ///
  ///
  ///



  Future<void> saveMovieAsFavorite(MovieDertailsModel movie) async {
    String? _favoriteMovies;

    try {
      _favoriteMovies = await getFavoriteMovies();
    } catch (e) {
      _favoriteMovies = null;
    }

    // there are no movies stored yet.
    if(_favoriteMovies == null) {
      String movieStr = movieDertailsModelToJson(movie);
      var movieStorageModel = MovieStorageModel(
        favoriteMovies: [],
      );
      movieStorageModel.favoriteMovies!.add(movieStr);

      String storage = movieStorageModelToJson(movieStorageModel);
      _write(storage);
    } else {

      //convert string coming from file to MovieStorageModel object.
      MovieStorageModel movieStorageModel = movieStorageModelFromJson(_favoriteMovies);

      // favorite movies are stored in String, convert them to MovieDetailsModel.
      List<MovieDertailsModel> _moviesDetails = movieStorageModel.favoriteMovies!.map((e) => movieDertailsModelFromJson(e)).toList();

      //if Movie is already registered
      if(_moviesDetails.any((element) => element.title == movie.title)){
        return;
      }

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

  Future deleteMovieFromFavorite(MovieDertailsModel movie) async {
    String? _favoriteMovies;
    try {
      _favoriteMovies = await getFavoriteMovies();
    } catch (e) {
      _favoriteMovies = null;
      return;
    }

    //convert string coming from file to MovieStorageModel object.
    MovieStorageModel movieStorageModel = movieStorageModelFromJson(_favoriteMovies!);

    // favorite movies are stored in String, convert them to MovieDetailsModel.
    List<MovieDertailsModel> _moviesDetails = movieStorageModel.favoriteMovies!.map((e) => movieDertailsModelFromJson(e)).toList();

    //remove movie
    _moviesDetails.removeWhere((element) => element.title == movie.title);

    //edit/update favoriteMovies
    movieStorageModel.favoriteMovies!.clear();
    movieStorageModel.favoriteMovies!.addAll(_moviesDetails.map((e) => movieDertailsModelToJson(e)).toList());


    // movieStorageModel is not a String,
    // so convert it to String then save it in file.
    String storage = movieStorageModelToJson(movieStorageModel);
    _write(storage);

  }

}
