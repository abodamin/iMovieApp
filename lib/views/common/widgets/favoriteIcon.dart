import 'package:flutter/foundation.dart';
import 'package:i_movie_app/app/imports.dart';


class FavoriteIcon extends StatefulWidget {
  FavoriteIcon({Key? key,
    required this.movie,
    required this.isFavorite,
    required this.onStoreCallback,
  }) : super(key: key);

  final movie;
  bool isFavorite;
  final VoidCallback onStoreCallback;

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {

  late final movie;

  @override
    void initState() {
      movie = widget.movie;

      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
          widget.isFavorite? Icons.favorite : Icons.favorite_border_outlined
      ),
      onPressed: () async {
        setState(() {
          widget.isFavorite = !widget.isFavorite;
        });
        widget.onStoreCallback.call();
      },
    );
  }
}
