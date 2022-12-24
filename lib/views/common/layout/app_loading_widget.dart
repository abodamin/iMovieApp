
import 'package:i_movie_app/app/imports.dart';
import 'package:i_movie_app/views/common/widgets/my_loading_widget.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getMediaHeight(context),
      child: Center(
        child: MyLoadingWidget(),
      ),
    );
  }
}
