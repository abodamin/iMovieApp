

import 'package:i_movie_app/data/api_models/MovieCastModel.dart';
import 'package:i_movie_app/data/api_models/MovieDetailsModel.dart';
import 'package:i_movie_app/data/api_models/SimilarMoviesModel.dart';
import 'package:i_movie_app/data/api_models/TrendingMoviesModel.dart';
import 'package:i_movie_app/domain/repository/movies_repository.dart';
import 'package:i_movie_app/views/details/details_page_data.dart';
import 'package:i_movie_app/views/factory/view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class DetailsPageViewModel extends ViewModel<DetailsPageData> {

  final MoviesRepository _repository;
  DetailsPageViewModel(this._repository) : super(DetailsPageData());

  Future<MovieDertailsModel> getMovieDetails(String id) async {
    return _repository.getMovieDetails(id);
  }

  Future<TrendingMoviesModel> getTrendingMovies() async {
    return await _repository.getTrendingMovies();
  }

  Future<SimilarMoviesModel> getSimilarMovies(String movieId) async {
    return await _repository.getSimilarMovies(movieId);
  }

  Future<MovieCastModel> getMovieCast(String movieId) async {
    return await _repository.getMovieCast(movieId);
  }


}