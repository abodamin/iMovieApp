import 'dart:math';

import 'package:flutter/services.dart';
import 'package:i_movie_app/app/imports.dart';

Decoration appGradient = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Color(0xFFFDCA46F),
      Color(0xFFFA47E5D),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
);

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');

  if (hexColor.length == 6) {
    hexColor = 'FF' + hexColor;
  }

  return Color(int.parse(hexColor, radix: 16));
}

spacerVertical(double v) {
  return Container(
    height: v,
    width: double.infinity,
  );
}

spacerHorizontal(double v) {
  return Container(
    height: v,
    width: v,
  );
}

spacer() {
  return SizedBox(
    height: 8,
  );
}

Future navigateTo(context, page) async {
  return await Navigator.push(
      context, MaterialPageRoute(builder: (context) => page));
}

TextStyle getMovieTitleStyle(BuildContext context){
  return getTextTheme(context).bodyMedium!;
}

InputDecoration txtField(String label) {
  return new InputDecoration(
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    hintText: label,
    hintStyle: TextStyle(color: Colors.grey),
    disabledBorder: InputBorder.none,
    contentPadding: EdgeInsets.only(left: 15, right: 15),
  );
}

Future<void> setUIOverlays() async {
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      systemNavigationBarColor: Colors.transparent,
    ),
  );

}

InputDecoration txtFieldLabel(String label) {
  return new InputDecoration(
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    labelText: label,
    disabledBorder: InputBorder.none,
    contentPadding: EdgeInsets.only(left: 5, right: 5),
  );
}

InputDecoration txtFieldSearch(String label) {
  return new InputDecoration(
    border: InputBorder.none,
    suffixIcon: Icon(Icons.clear),
    disabledBorder: InputBorder.none,
    contentPadding: EdgeInsets.only(left: 15, right: 15),
  );
}

circularImage(String im, double width, double height) {
  return new Container(
    width: 190.0,
    height: 190.0,
    decoration: new BoxDecoration(
      shape: BoxShape.circle,
      image: new DecorationImage(
        fit: BoxFit.fill,
        image: new AssetImage(im),
      ),
    ),
  );
}

circularImage2(String im, double width, double height) {
  return new Container(
    width: width,
    height: height,
    decoration: new BoxDecoration(
      shape: BoxShape.circle,
      image: new DecorationImage(
        fit: BoxFit.fill,
        image: new AssetImage(im),
      ),
    ),
  );
}

Widget mDivider(Color color) {
  return Divider(
    // width: double.infinity,
    height: 1,
    color: color,
  );
}

Widget mFlex(int f) {
  return Flexible(
    flex: f,
    child: Container(),
  );
}

mOverlay(double op) {
  return Opacity(
    opacity: op,
    child: Container(
      color: Colors.black,
      width: double.infinity,
      height: double.infinity,
    ),
  );
}

Widget mHeight(double h) {
  return Container(
    height: h,
  );
}

Widget mWidth(double w) {
  return Container(
    width: w,
  );
}

RoundedRectangleBorder buttonShape() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(14.0),
  );
}

Widget buttonText(String txt) {
  return Ink(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFFA47E5D),
          Color(0xFFFDCA46F),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
    ),
    child: Container(
      alignment: Alignment.center,
      height: 50,
      constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
      child: Text(
        txt,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  );
}

Widget buttonTextGreen(BuildContext context, String txt) {
  return Ink(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [primaryColor, primaryColor],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
    ),
    child: Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
      height: 50,
      child: Text(
        txt,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    ),
  );
}

Decoration containerRadiusWithGradient(double radius) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    gradient: LinearGradient(
      colors: [
        Color(0xFFFDCA46F),
        Color(0xFFFA47E5D),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  );
}

Decoration containerRadius(Color background, double radius) {
  return BoxDecoration(
    color: background,
    border: Border.all(
        width: 1, //
        color: background //                  <--- border width here
        ),
    borderRadius: BorderRadius.circular(radius),
  );
}

Decoration containerColorRadiusBorder(
    Color background, double radius, Color color) {
  return BoxDecoration(
    color: background,
    border: Border.all(
        width: 1, //
        color: color //                  <--- border width here
        ),
    borderRadius: BorderRadius.circular(radius),
  );
}

Decoration containerColorRadiusBorderWidth(
    Color background, double radius, Color color, double w) {
  return BoxDecoration(
    color: background,
    border: Border.all(
        width: w, //
        color: color //                  <--- border width here
        ),
    borderRadius: BorderRadius.circular(radius),
  );
}

Decoration containerColorRadiusRight(Color background, double radius) {
  return BoxDecoration(
    color: background,
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(radius),
        bottomRight: Radius.circular(radius)),
  );
}

Decoration containerColorRadiusRightBorder(
    Color background, double radius, double w) {
  return BoxDecoration(
    color: background,
    border: Border.all(
        width: w, //
        color: Colors.white //                  <--- border width here
        ),
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(radius),
        bottomRight: Radius.circular(radius)),
  );
}

Decoration containerColorRadiusRightBorderc(
    Color background, double radius, double w, Color borderColor) {
  return BoxDecoration(
    color: background,
    border: Border.all(
        width: w, //
        color: borderColor //                  <--- border width here
        ),
    borderRadius: BorderRadius.circular(radius),
  );
}

Decoration containerColorRadiusTop(Color color, double radius) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    ),
  );
}

Decoration containerColorRadiusBottom(Color color, double radius) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(radius),
      bottomRight: Radius.circular(radius),
    ),
  );
}

Decoration containerColorRadiusLeftBorder(
    Color background, double radius, double w) {
  return BoxDecoration(
    color: background,
    border: Border.all(
        width: w, //
        color: Colors.white //                  <--- border width here
        ),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius), bottomLeft: Radius.circular(radius)),
  );
}

ShapeBorder cardRadius(double radius) {
  return RoundedRectangleBorder(
    side: BorderSide(color: Colors.transparent, width: 1),
    borderRadius: BorderRadius.circular(radius),
  );
}

ShapeBorder cardRadiusTop(double radius) {
  return RoundedRectangleBorder(
    side: BorderSide(color: Colors.transparent, width: 0),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
  );
}

ShapeBorder cardRadiusTop2(double radius) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
  );
}

ShapeBorder cardRadiusBottom(double radius) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius)),
  );
}

ShapeBorder cardRadiusWithoutBorder(double radius) {
  return RoundedRectangleBorder(
    side: BorderSide(color: Colors.transparent, width: 1),
    borderRadius: BorderRadius.circular(radius),
  );
}

ShapeBorder cardRadiusWithBorder(double radius) {
  return RoundedRectangleBorder(
    side: BorderSide(color: Colors.grey, width: 1),
    borderRadius: BorderRadius.circular(radius),
  );
}

ShapeBorder cardRadiusBorder(double radius, double w) {
  return RoundedRectangleBorder(
    side: BorderSide(color: Colors.transparent, width: w),
    borderRadius: BorderRadius.circular(radius),
  );
}

ShapeBorder cardColorRadiusBorder(Color color, double radius, double w) {
  return RoundedRectangleBorder(
    side: BorderSide(color: color, width: w),
    borderRadius: BorderRadius.circular(radius),
  );
}

// String properRound(double val, int places) {
//   double mod = pow(10.0, places);
//   double result = ((val * mod).round().toDouble() / mod);
//   return result.toString();
// }
//
// double properRoundDouble(double val, int places) {
//   double mod = pow(10.0, places);
//   double result = ((val * mod).round().toDouble() / mod);
//   return result;
// }
//var cardShape = RoundedRectangleBorder(
//  side: BorderSide(color: Colors.white70, width: 1),
//  borderRadius: BorderRadius.circular(10),
//);

//await Navigator.of(context).push(new MaterialPageRoute<dynamic>(
//builder: (BuildContext context) {
//return AdminTeamAvaluatePage(widget.competitionID, data);
//},
//));
//setState(() {});
