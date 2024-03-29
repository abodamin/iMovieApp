

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
import 'package:i_movie_app/domain/repository/movies_repository.dart';
import 'package:i_movie_app/views/factory/view_model.dart';
import 'package:i_movie_app/views/home/home_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomePageViewModel extends ViewModel<HomeData>{

  final MoviesRepository _repository;

  HomePageViewModel(this._repository) : super(HomeData());


  Future<TrendingMoviesModel> getTrendingMovies() async {
    return await _repository.getTrendingMovies();
  }

  Future<GenresModel> getGenres() async {
    return await _repository.getGenres();
  }


  Future<GenreMoviesModel> getGenreMovies(int id) async {
    return await _repository.getGenreMovies(id);
  }

  Future<MovieCastModel> getMovieCast(String id) async {
    return await _repository.getMovieCast(id);
  }

  Future<TreindingPeopleModel> getTrendinPersons() async {
    return await _repository.getTrendinPersons();
  }

  Future<TopRatedMviesModel> getTopRatedMovies() async {
    return await _repository.getTopRatedMovies();
  }

  Future<SimilarMoviesModel> getSimilarMovis(String id) async {
    return await _repository.getSimilarMovies(id);
  }

  Future<MovieDertailsModel> getMovieDetails(String id) async {
    return await _repository.getMovieDetails(id);
  }

  Future<MovieVideos> getMovieVideos(String id) async {
    return await _repository.getMovieVideos(id);
  }

  Future<SearchMovieResult> searchForMovie(String keyWord) async {
    return await _repository.searchForMovie(keyWord);
  }

  Future<SearchByGenreResult> searchByGenre(
      String genreIDs, String year) async {
    return await _repository.searchByGenre(genreIDs, year);
  }

}