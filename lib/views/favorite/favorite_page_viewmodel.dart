
 import 'package:i_movie_app/data/api_models/MovieDetailsModel.dart';
import 'package:i_movie_app/data/local_models/movie_details_starage.dart';
import 'package:i_movie_app/domain/repository/storage_repository.dart';
import 'package:i_movie_app/views/factory/view_model.dart';
import 'package:i_movie_app/views/favorite/favorite_page_data.dart';
import 'package:injectable/injectable.dart';


@injectable
class FavoritePageViewModel extends ViewModel<FavoritePageData>{
  final StorageRepository _storageRepository;
  FavoritePageViewModel(this._storageRepository) : super(FavoritePageData());


  Future<Set<MovieDertailsModel>> getFavoriteMovies() async {
    String? _favoriteMovies = await _storageRepository.getFavoriteMovies();

    MovieStorageModel movieStorageModel = movieStorageModelFromJson(_favoriteMovies!);

    // favorite movies are stored in String, convert them to MovieDetailsModel.
    return movieStorageModel.favoriteMovies!.map((e) => movieDertailsModelFromJson(e)).toSet();
  }

}