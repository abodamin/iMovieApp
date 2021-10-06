import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:i_movie_app/UI/Widgets/Utils.dart';

class AdaptiveButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double radius;
  final Color color;

  const AdaptiveButton({
    Key key,
    @required this.onPressed,
    @required this.child,
    this.color,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? MaterialButton(
            shape: cardRadius(radius ?? 8),
            color: color,
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 12,
              ),
              child: child,
            ),
          )
        : CupertinoButton(
            child: child,
            color: color,
            borderRadius: BorderRadius.circular(radius ?? 8),
            onPressed: onPressed,
          );
  }
}
