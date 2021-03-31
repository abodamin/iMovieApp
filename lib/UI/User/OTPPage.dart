import 'package:i_movie_app/App/imports.dart';

class OTPPage extends StatelessWidget {
  final TextEditingController _code1 = TextEditingController();
  final TextEditingController _code2 = TextEditingController();
  final TextEditingController _code3 = TextEditingController();
  final TextEditingController _code4 = TextEditingController();

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
              margin: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 1,
                    child: Card(
                      elevation: 4,
                      shape: cardColorRadiusBorder(Colors.grey, 8, 2),
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _code1,
                              keyboardType: TextInputType.number,
                              decoration: txtField(""),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //
                  Flexible(
                    flex: 1,
                    child: Card(
                      elevation: 4,
                      shape: cardColorRadiusBorder(Colors.grey, 8, 2),
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: TextField(
                              controller: _code2,
                              keyboardType: TextInputType.number,
                              decoration: txtField(""),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //
                  Flexible(
                    flex: 1,
                    child: Card(
                      elevation: 4,
                      shape: cardColorRadiusBorder(Colors.grey, 8, 2),
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: TextField(
                              controller: _code3,
                              keyboardType: TextInputType.number,
                              decoration: txtField(""),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //
                  Flexible(
                    flex: 1,
                    child: Card(
                      elevation: 4,
                      shape: cardColorRadiusBorder(Colors.grey, 8, 2),
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: TextField(
                              controller: _code4,
                              keyboardType: TextInputType.number,
                              decoration: txtField(""),
                            ),
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
              margin: const EdgeInsets.all(16),
              child: FlatButton(
                shape: cardRadius(8),
                color: Colors.grey,
                onPressed: () {
                  //
                },
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
                // navigateTo(context, LoginPage());
              },
              child: RichText(
                text: TextSpan(
                  text: 'لم تحصل على الرمز؟',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' اعادة ارسال ',
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
