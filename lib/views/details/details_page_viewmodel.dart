

import 'package:i_movie_app/data/api_models/MovieCastModel.dart';
import 'package:i_movie_app/data/api_models/MovieDetailsModel.dart';
import 'package:i_movie_app/data/api_models/SimilarMoviesModel.dart';
import 'package:i_movie_app/data/api_models/TrendingMoviesModel.dart';
import 'package:i_movie_app/data/local_models/movie_details_starage.dart';
import 'package:i_movie_app/domain/repository/movies_repository.dart';
import 'package:i_movie_app/domain/repository/storage_repository.dart';
import 'package:i_movie_app/views/details/details_page_data.dart';
import 'package:i_movie_app/views/factory/view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class DetailsPageViewModel extends ViewModel<DetailsPageData> {

  final MoviesRepository _repository;
  final StorageRepository _storageRepository;
  DetailsPageViewModel(this._repository, this._storageRepository) : super(DetailsPageData());

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

  Future<bool> isMovieFavorite(MovieDertailsModel movie) async {
    try{
      String? _favoriteMovies = await _storageRepository.getFavoriteMovies();
      if(_favoriteMovies == null){
        return false;
      }
        MovieStorageModel movieStorageModel = movieStorageModelFromJson(_favoriteMovies);
        // favorite movies are stored in String, convert them to MovieDetailsModel.
        List<MovieDertailsModel> _moviesDetails = movieStorageModel.favoriteMovies!.map((e) => movieDertailsModelFromJson(e)).toList();
        // _details.addAll(movieStorageModel.favoriteMovies!.map((e) => movieDertailsModelFromJson(e)).toList());
        return _moviesDetails.any((element) => element.title == movie.title);
      } catch(e){
      print("___ERRORRRR >> $e");
        return false;
      }
  }

  Future<void> saveMovieAsFavorite(MovieDertailsModel movie) async {
      await _storageRepository.saveMovieAsFavorite(movie);
  }


}