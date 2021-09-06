import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:i_movie_app/App/imports.dart';
import 'package:i_movie_app/UI/Widgets/avatar_photo.dart';

class CastCard extends StatelessWidget {
  final String imagePath, actorName, bio;

  const CastCard({
    Key key,
    @required this.imagePath,
    @required this.actorName,
    @required this.bio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: containerColorRadiusBorder(
            Colors.transparent,
            300,
            Colors.transparent,
          ),
          width: get80Size(context),
          height: get80Size(context),
          clipBehavior: Clip.antiAlias,
          child: AvatarPhoto(
            photoPath: "$imagePath",
            height: get20Size(context),
          ),
        ),
        Text(
          "${actorName ?? "NA"}",
          style: getTextTheme(context).button,
        ),
        AutoSizeText(
          "${bio ?? ". . ."}",
          style: getTextTheme(context).caption,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
