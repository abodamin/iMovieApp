import 'package:i_movie_app/data/api_models/GenreMoviesModel.dart';
import 'package:i_movie_app/data/api_models/GenresModel.dart';
import 'package:i_movie_app/data/api_models/MovieCastModel.dart';
import 'package:i_movie_app/data/api_models/MovieDetailsModel.dart';
import 'package:i_movie_app/data/api_models/SimilarMoviesModel.dart';
import 'package:i_movie_app/data/api_models/TopRatedMoviesModel.dart';
import 'package:i_movie_app/data/api_models/TrendingMoviesModel.dart';
import 'package:i_movie_app/data/api_models/TrendingPeople.dart';
import 'package:i_movie_app/data/api_models/movie_videos.dart';
import 'package:i_movie_app/data/api_models/search_by_genre_result.dart';
import 'package:i_movie_app/data/api_models/search_movies_result.dart';
import 'package:i_movie_app/data/network/rest_api.dart';
import 'package:injectable/injectable.dart';

@singleton
class MoviesRepository {
  final RestApi _restApi;

  MoviesRepository(this._restApi);

  Future<TrendingMoviesModel> getTrendingMovies() async {
    return await _restApi.getTrendingMovies();
  }

  Future<GenresModel> getGenres() async {
    return await _restApi.getGenres();
  }

  Future<GenreMoviesModel> getGenreMovies(int id) async {
    return await _restApi.getGenreMovies(id);
  }

  Future<MovieCastModel> getMovieCast(String id) async {
    return await _restApi.getMovieCast(id);
  }

  Future<TreindingPeopleModel> getTrendinPersons() async {
    return await _restApi.getTrendinPersons();
  }

  Future<TopRatedMviesModel> getTopRatedMovies() async {
    return await _restApi.getTopRatedMovies();
  }

  Future<SimilarMoviesModel> getSimilarMovies(String id) async {
    return await _restApi.getSimilarMovis(id);
  }

  Future<MovieDertailsModel> getMovieDetails(String id) async {
    return await _restApi.getMovieDetails(id);
  }

  Future<MovieVideos> getMovieVideos(String id) async {
    return await _restApi.getMovieVideos(id);
  }

  Future<SearchMovieResult> searchForMovie(String keyWord) async {
    return await _restApi.searchForMovie(keyWord);
  }

  Future<SearchByGenreResult> searchByGenre(
      String genreIDs, String year) async {
    return await _restApi.searchByGenre(genreIDs, year);
  }
}
