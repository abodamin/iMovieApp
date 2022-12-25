
import 'package:i_movie_app/app/imports.dart';
import 'package:i_movie_app/views/common/widgets/gradient_image.dart';

class MoviePosterImage extends StatelessWidget {
  final String item;

  const MoviePosterImage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: get200Size(context) + get50Size(context),
      width: getMediaWidth(context),
      child: GredientImage(
        imageName: item.toString() ?? "",
      ),
    );
  }
}
