


import 'package:i_movie_app/app/imports.dart';

class GredientImage extends StatelessWidget {
  final String imageName;

  const GredientImage({
    Key? key,
    required this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: getMediaWidth(context),
          child: Image.network(
            imageName,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.transparent,
                primaryColor,
              ],
              stops: [0.0, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}
