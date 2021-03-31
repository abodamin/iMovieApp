import 'package:flutter/material.dart';
import 'package:i_movie_app/UI/Home/HomePage.dart';
import 'package:i_movie_app/UI/User/LoginPage.dart';
import 'package:i_movie_app/UI/User/RegistrationPage.dart';
import 'package:i_movie_app/UI/Widgets/Responsive.dart';
import 'package:i_movie_app/UI/Widgets/Utils.dart';

class LoginMain extends StatefulWidget {
  @override
  _LoginMainState createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: MediaQuery.of(context).size.height * 0.9,
        width: getMediaWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              child: FlutterLogo(
                size: 100,
              ),
            ),
            mFlex(1),
            Container(
              width: MediaQuery.of(context).size.width,
              child: FlatButton.icon(
                color: Colors.grey,
                shape: cardRadius(8),
                onPressed: () {
                  navigateTo(context, LoginPage());
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: Text(
                  "تسجيل دخول",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: FlatButton.icon(
                color: Colors.grey,
                shape: cardRadius(8),
                onPressed: () {
                  navigateTo(context, RegisterPage());
                },
                icon: Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
                label: Text(
                  "تسجيل ",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            mFlex(1),
            Container(
              width: MediaQuery.of(context).size.width,
              child: FlatButton.icon(
                shape: cardColorRadiusBorder(Colors.grey, 8, 2),
                onPressed: () {
                  //
                  navigateTo(context, HomePage());
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                label: Text(
                  "استمر كضيف",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
