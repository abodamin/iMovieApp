import 'package:i_movie_app/App/imports.dart';
import 'package:i_movie_app/Model/MovieDetailsModel.dart';

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({Key key, @required this.movie}) : super(key: key);

  final  movie;

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  bool isBooked = false;
  var movie;

  @override
    void initState() {
      movie = widget.movie;
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
          isBooked? Icons.favorite : Icons.favorite_border_outlined
      ),
      onPressed: () {
        setState(() {
          isBooked = !isBooked;
        });
      },
    );
  }
}
