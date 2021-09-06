import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:i_movie_app/Model/assets_names.dart';

class AvatarPhoto extends StatelessWidget {
  final String photoPath;
  final double height;

  const AvatarPhoto({
   @required this.photoPath,
    @required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CachedNetworkImage(
        placeholder: (context, url) => Container(
          child: Image.asset(
          R.ic_person,
            width: double.infinity,
            height: height,
            fit: BoxFit.cover,
          ),
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Material(
          child: Image.asset(
          R.ic_person,
            width: double.infinity,
            height: height,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          clipBehavior: Clip.hardEdge,
        ),
        imageUrl: photoPath,
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
