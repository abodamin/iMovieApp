import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_movie_app/App/imports.dart';

class BackArrowIcon extends StatelessWidget {
  const BackArrowIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: containerColorRadiusBorder(Colors.black38, 100, Colors.transparent),
      child: IconButton(
        icon: Platform.isAndroid
            ? Icon(Icons.arrow_back)
            : Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
