

import 'package:i_movie_app/views/factory/view_model.dart';
import 'package:i_movie_app/views/home/home_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomePageViewModel extends ViewModel<HomeData>{

  HomePageViewModel() : super(HomeData());

}