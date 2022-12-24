

import 'package:i_movie_app/views/details/details_page_data.dart';
import 'package:i_movie_app/views/factory/view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class DetailsPageViewModel extends ViewModel<DetailsPageData> {

  DetailsPageViewModel() : super(DetailsPageData());
}