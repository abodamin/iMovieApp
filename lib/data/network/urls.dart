import 'package:i_movie_app/app/Globals.dart';
import 'package:injectable/injectable.dart';

// ignore_for_file: lines_longer_than_80_chars
@singleton
class URLS {
  // -- APIs -- //
  static const String DEV_URL = "https://api.themoviedb.org";
  static const String PROD_URL = "";
  static const String BASE_URL = DEV_URL;
  static const String V3 = "3/";
  //
  static const String TRENDING_MOVIES = V3 + "trending/movie/week?api_key=$mApiKey";
  static const String GET_GENRES = V3 + "genre/movie/list?api_key=$mApiKey&language=en-US";

  static String GET_GENRE_MOVIES = "3/discover/movie?api_key=$mApiKey&";



}
