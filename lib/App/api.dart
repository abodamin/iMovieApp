import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:i_movie_app/App/Globals.dart';
import 'package:i_movie_app/Model/GenreMoviesModel.dart';
import 'package:i_movie_app/Model/GenresModel.dart';
import 'package:i_movie_app/Model/MovieCastModel.dart';
import 'package:i_movie_app/Model/MovieDetailsModel.dart';
import 'package:i_movie_app/Model/SimilarMoviesModel.dart';
import 'package:i_movie_app/Model/TopRatedMoviesModel.dart';
import 'package:i_movie_app/Model/TrendingMoviesModel.dart';
import 'package:i_movie_app/Model/TrendingPeople.dart';
import 'package:i_movie_app/Model/movie_videos.dart';
import 'package:i_movie_app/Model/search_by_genre_result.dart';
import 'package:i_movie_app/Model/search_movies_result.dart';

class ApiClient {
  ApiClient._();

  static final ApiClient apiClient = ApiClient._();
  static final http.Client _httpClient = http.Client();
  //Dev API
  static final String _DEV_URL = "https://api.themoviedb.org";

  ///movie/latest
  //Prod API
  // static final String _DEV_URL = "https://blabla-prod.com/";
  static final String BASE_URL = "$_DEV_URL";

  Future<TrendingMoviesModel> getTrendingMovies() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      // 'token': mUserToken,
    };

    try {
      final response = await _httpClient.get(
        Uri.parse("$BASE_URL/3/trending/movie/week?api_key=$mApiKey"),
        headers: header,
      );

       // print("getTrendingMovies " + response.body);
      final parsed = json.decode(response.body);
      return TrendingMoviesModel.fromJson(parsed);
    } on SocketException {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error("Server Error");
    }
  }

  Future<GenresModel> getGenres() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      // 'token': mUserToken,
    };

    try {
      final response = await _httpClient.get(
        Uri.parse("$BASE_URL/3/genre/movie/list?api_key=$mApiKey&language=en-US"),
        headers: header,
      );

       // print("getGenres " + response.body);
      //return parseOtp(response.body);
      final parsed = json.decode(response.body);
      return GenresModel.fromJson(parsed);
    } on SocketException {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error("Server Error");
    }
  }

  Future<GenreMoviesModel> getGenreMovies(int id) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      // 'token': mUserToken,
    };

    try {
      final response = await _httpClient.get(
        Uri.parse("$BASE_URL/3/discover/movie?api_key=$mApiKey&with_genres=$id"),
        headers: header,
      );

       // print("getGenreMovies " + response.body);
      final parsed = json.decode(response.body);
      return GenreMoviesModel.fromJson(parsed);
    } on SocketException {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error("Server Error");
    }
  }

  Future<MovieCastModel> getMovieCast(String id) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      // 'token': mUserToken,
    };

    try {
      final response = await _httpClient.get(
        Uri.parse("$BASE_URL/3/movie/$id/casts?api_key=$mApiKey"),
        headers: header,
      );

       // print("getMovieCast " + response.body);
      //return parseOtp(response.body);
      final parsed = json.decode(response.body);
      return MovieCastModel.fromJson(parsed);
    } on SocketException {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error("Server Error");
    }
  }

  Future<TreindingPeopleModel> getTrendinPersons() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      // 'token': mUserToken,
    };

    try {
      final response = await _httpClient.get(
        Uri.parse("$BASE_URL/3/person/popular?api_key=$mApiKey&language=en-US&page=1"),
        headers: header,
      );

       // print("getTrendinPersons " + response.body);
      //return parseOtp(response.body);
      final parsed = json.decode(response.body);
      return TreindingPeopleModel.fromJson(parsed);
    } on SocketException {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error("Server Error");
    }
  }

  Future<TopRatedMviesModel> getTopRatedMovies() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      // 'token': mUserToken,
    };
    try {
      final response = await _httpClient.get(
        Uri.parse("$BASE_URL/3/movie/top_rated?api_key=$mApiKey&language=en-US&page=1"),
        headers: header,
      );
       // print("TopRatedMviesModel " + response.body);
      //return parseOtp(response.body);
      final parsed = json.decode(response.body);
      return TopRatedMviesModel.fromJson(parsed);
    } on SocketException {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error("Server Error");
    }
  }

  Future<SimilarMoviesModel> getSimilarMovis(String id) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      // 'token': mUserToken,
    };
    try {
      final response = await _httpClient.get(
        //https://api.themoviedb.org/3/movie/12/similar?api_key={{ApiKey}}&language=en-US&page=1
        Uri.parse("$BASE_URL/3/movie/$id/similar?api_key=$mApiKey&language=en-US&page=1"),
        headers: header,
      );
       // print("getSimilarMovis " + response.body);
      //return parseOtp(response.body);
      final parsed = json.decode(response.body);
      return SimilarMoviesModel.fromJson(parsed);
    } on SocketException {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error("Server Error");
    }
  }

  Future<MovieDertailsModel> getMovieDetails(String id) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      // 'token': mUserToken,
    };
    try {
      final response = await _httpClient.get(
        //https://api.themoviedb.org/3/movie/18?api_key={{ApiKey}}&language=en-US
        Uri.parse("$BASE_URL/3/movie/$id?api_key=$mApiKey&language=en-US"),
        headers: header,
      );
       // print("getMovieDetails " + response.body);
      //return parseOtp(response.body);
      final parsed = json.decode(response.body);
      return MovieDertailsModel.fromJson(parsed);
    } on SocketException {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error("Server Error");
    }
  }

  Future<MovieVideos> getMovieVideos(String id) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };
    try {
      final response = await _httpClient.get(
        Uri.parse("$BASE_URL/3/movie/$id/videos?api_key=$mApiKey"),
        headers: header,
      );
       // print("getMovieVideos ApiCall: $BASE_URL/3/movie/$id/videos?api_key=$mApiKey");
       // print("getMovieVideos " + response.body);
      final parsed = json.decode(response.body);
      return MovieVideos.fromJson(parsed);
    } on SocketException {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error("Server Error");
    }
  }

  Future<SearchMovieResult> searchforMovie(String keyWord) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };

    String searchURI = Uri.dataFromString(keyWord).data.contentText;
    // mLogger.i(searchURI);

    try {
      final response = await _httpClient.get(
        Uri.parse("$BASE_URL/3/search/movie?api_key=$mApiKey&language=en-US&query=${searchURI}&page=1&include_adult=true"),
        headers: header,
      );

       // print("___searchforMovie API " + "$BASE_URL/3/search/movie?api_key=$mApiKey&language=en-US&query=$searchURI&page=1&include_adult=true");
       // print("searchforMovie " + response.body);
      final parsed = json.decode(response.body);
      return SearchMovieResult.fromJson(parsed);
    } on SocketException {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error("Server Error");
    }
  }


  Future<SearchByGenreResult> searchByGenre(String genreIDs, String year) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };
    try {
      final response = await _httpClient.get(
        Uri.parse("$BASE_URL/3/discover/movie?api_key=$mApiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_date.gte=1990-01-01&primary_release_date.lte=$year-12-31&vote_average.gte=6&with_genres=$genreIDs"),
        headers: header,
      );
      //  // print("___searchforMovie API " + "$BASE_URL/3/search/movie?api_key=$mApiKey&language=en-US&query=$searchURI&page=1&include_adult=true");
       // print("searchByGenre " + response.body);
      final parsed = json.decode(response.body);
      return SearchByGenreResult.fromJson(parsed);
    } on SocketException {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error("Server Error");
    }
  }

}
