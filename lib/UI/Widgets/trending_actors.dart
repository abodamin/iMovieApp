import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:i_movie_app/App/imports.dart';
import 'package:i_movie_app/Model/TrendingPeople.dart' as trendingPeople;
import 'package:i_movie_app/Model/assets_names.dart';
import 'package:i_movie_app/UI/Widgets/avatar_photo.dart';

class TrendingActors extends StatelessWidget {
  final trendingPeople.Result data;

  const TrendingActors({
    Key key,
    @required this.data,
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
            photoPath: R.getNetworkImagePath(data.profilePath),
            height: get50Size(context),
          ),
        ),
        Text(
          "${data.name}",
          style: getTextTheme(context).button,
        ),
        AutoSizeText(
          "Trending for ${data.knownForDepartment ?? ""}",
          style: getTextTheme(context).caption,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
