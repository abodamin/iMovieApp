
 import 'package:i_movie_app/data/api_models/SimilarMoviesModel.dart';
import 'package:i_movie_app/domain/repository/movies_repository.dart';
import 'package:i_movie_app/views/factory/view_model.dart';
import 'package:i_movie_app/views/favorite/favorite_page_data.dart';
import 'package:injectable/injectable.dart';


@injectable
class FavoritePageViewModel extends ViewModel<FavoritePageData>{
  final MoviesRepository _repository;
  FavoritePageViewModel(this._repository) : super(FavoritePageData());

  Future<SimilarMoviesModel> getSimilarMovis(String id) async{
    return await _repository.getSimilarMovies(id);
  }

}