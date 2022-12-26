import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:i_movie_app/app/Globals.dart';
import 'package:i_movie_app/data/api_models/GenresModel.dart';
import 'package:i_movie_app/data/api_models/TrendingMoviesModel.dart';
import 'package:i_movie_app/data/network/reponse_exception.dart';
import 'package:i_movie_app/data/network/urls.dart';
import 'package:injectable/injectable.dart';

import 'package:i_movie_app/data/api_models/MovieCastModel.dart';
import 'package:i_movie_app/data/api_models/MovieDetailsModel.dart';
import 'package:i_movie_app/data/api_models/SimilarMoviesModel.dart';
import 'package:i_movie_app/data/api_models/TopRatedMoviesModel.dart';

import 'package:i_movie_app/data/api_models/GenreMoviesModel.dart';

import 'package:i_movie_app/data/api_models/TrendingPeople.dart';
import 'package:i_movie_app/data/api_models/movie_videos.dart';
import 'package:i_movie_app/data/api_models/search_by_genre_result.dart';
import 'package:i_movie_app/data/api_models/search_movies_result.dart';

@injectable
class RestApi {
  RestApi(this._dio);

  final Dio _dio;

  Future<TrendingMoviesModel> getTrendingMovies() async {
    try {
      final Response response = await _dio.get(
        URLS.TRENDING_MOVIES,
      );

      // print("___getTrendingMovies >> " + response.data);
      // final parsed = json.decode(response.data.toString());
      return TrendingMoviesModel.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = ResponseException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<GenresModel> getGenres() async {
    try {
      final response = await _dio.get(
        URLS.GET_GENRES,
      );

      // print("getGenres " + response.body);
      //return parseOtp(response.body);
      // // final parsed = json.decode(response.data);
      return GenresModel.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = ResponseException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<GenreMoviesModel> getGenreMovies(int id) async {
    try {
      final response = await _dio.get(
        URLS.GET_GENRE_MOVIES + "with_genres=$id",
      );

      // print("getGenreMovies " + response.body);
      // final parsed = json.decode(response.data);
      return GenreMoviesModel.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = ResponseException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<MovieCastModel> getMovieCast(String id) async {
    try {
      final response = await _dio.get(
        "3/movie/$id/casts?api_key=$mApiKey",
      );

      // print("getMovieCast " + response.body);
      //return parseOtp(response.body);
      // final parsed = json.decode(response.data);
      return MovieCastModel.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = ResponseException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<TreindingPeopleModel> getTrendinPersons() async {
    try {
      final response = await _dio
          .get("3/person/popular?api_key=$mApiKey&language=en-US&page=1");

      // print("getTrendinPersons " + response.body);
      //return parseOtp(response.body);
      // final parsed = json.decode(response.data);
      return TreindingPeopleModel.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = ResponseException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<TopRatedMviesModel> getTopRatedMovies() async {
    try {
      final response = await _dio
          .get("3/movie/top_rated?api_key=$mApiKey&language=en-US&page=1");

      // print("TopRatedMviesModel " + response.body);
      //return parseOtp(response.body);
      // final parsed = json.decode(response.data);
      return TopRatedMviesModel.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = ResponseException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<SimilarMoviesModel> getSimilarMovis(String id) async {
    try {
      final response = await _dio.get(
          //https://api.themoviedb.org/3/movie/12/similar?api_key={{ApiKey}}&language=en-US&page=1
          "3/movie/$id/similar?api_key=$mApiKey&language=en-US&page=1");
      // print("getSimilarMovis " + response.data);
      //return parseOtp(response.data);
      // final parsed = json.decode(response.data);
      return SimilarMoviesModel.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = ResponseException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<MovieDertailsModel> getMovieDetails(String id) async {
    try {
      final response = await _dio.get(
          //https://api.themoviedb.org/3/movie/18?api_key={{ApiKey}}&language=en-US
          "3/movie/$id?api_key=$mApiKey&language=en-US");
      // print("getMovieDetails " + response.data);
      //return parseOtp(response.data);
      // final parsed = json.decode(response.data);
      return MovieDertailsModel.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = ResponseException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<MovieVideos> getMovieVideos(String id) async {
    try {
      final response = await _dio.get("3/movie/$id/videos?api_key=$mApiKey");
      // print("getMovieVideos ApiCall: 3/movie/$id/videos?api_key=$mApiKey");
      // print("getMovieVideos " + response.data);
      // final parsed = json.decode(response.data);
      return MovieVideos.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = ResponseException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<SearchMovieResult> searchForMovie(String keyWord) async {
    String searchURI = Uri.dataFromString(keyWord).data!.contentText;
    // mLogger.i(searchURI);

    try {
      final response = await _dio.get(
          "3/search/movie?api_key=$mApiKey&language=en-US&query=${searchURI}&page=1&include_adult=false");

      // print("___searchforMovie API " + "3/search/movie?api_key=$mApiKey&language=en-US&query=$searchURI&page=1&include_adult=true");
      // print("searchforMovie " + response.data);
      // final parsed = json.decode(response.data);
      return SearchMovieResult.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = ResponseException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<SearchByGenreResult> searchByGenre(
    String genreIDs,
    String year,
  ) async {
    try {
      final response = await _dio.get(
          "3/discover/movie?api_key=$mApiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_date.gte=1990-01-01&primary_release_date.lte=$year-12-31&vote_average.gte=6&with_genres=$genreIDs");
      //  // print("___searchforMovie API " + "3/search/movie?api_key=$mApiKey&language=en-US&query=$searchURI&page=1&include_adult=true");
      // print("searchByGenre " + response.data);
      // final parsed = json.decode(response.data);
      return SearchByGenreResult.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = ResponseException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

//  ----------------------  //



//  ----------------------  //

}
