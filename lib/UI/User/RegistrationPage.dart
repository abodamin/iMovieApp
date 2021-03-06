import 'package:i_movie_app/App/imports.dart';
import 'package:i_movie_app/UI/User/LoginPage.dart';

class RegisterPage extends StatelessWidget {
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 3,
              child: FlutterLogo(
                size: 100,
              ),
              // child: Image.asset('assets/images/ic_launcher.png'),
            ),
            mFlex(1),
            Text("تسجيل"),
            Text("ادخل رقم هاتفك المحمول وسارسل لك رسالة نصية للتحقق"),
            Container(
              width: MediaQuery.of(context).size.width,
              clipBehavior: Clip.antiAlias,
              decoration: containerColorRadiusBorder(
                  Colors.transparent, 8, Colors.grey),
              child: TextField(
                decoration: txtField("البريد الالكتروني"),
              ),
            ),
            mHeight(8),
            //--
            Container(
              width: MediaQuery.of(context).size.width,
              clipBehavior: Clip.antiAlias,
              decoration: containerColorRadiusBorder(
                  Colors.transparent, 8, Colors.grey),
              child: Row(
                children: [
                  Flexible(
                    flex: 7,
                    child: Container(
                      // padding: const EdgeInsets.all(8),
                      child: Container(
                        //
                        child: TextField(
                          decoration: txtField("ادخل رقم هاتفك"),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: get20Size(context),
                      color: Colors.grey,
                      child: Center(
                        child: Text(
                          "966",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            mHeight(4),
            Container(
              width: double.infinity,
              child: FlatButton(
                shape: cardRadius(8),
                color: Colors.grey,
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "استمرار",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            mFlex(1),
            GestureDetector(
              onTap: () {
                navigateTo(context, LoginPage());
              },
              child: RichText(
                text: TextSpan(
                  text: 'لديك حساب بالفعل؟ ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.normal),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'تسجيل دخول',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        )),
                    // TextSpan(text: ' world!'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
