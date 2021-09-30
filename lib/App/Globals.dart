import 'package:logger/logger.dart';

bool isLoggedIn = false;
String appName = "iMovieApp";
String mUserID = "";
String mUserName = "";
String mUserToken = "";
String mApiKey = "bc32768658a42dbf7f60e40743074f79";
String imgBaseURLHQ = "https://image.tmdb.org/t/p/original";
String imgBaseURLLQ = "https://image.tmdb.org/t/p/w185";
String mDisplayName = "";
String mUserImage = "";
bool isDev = false;

Logger mLogger = Logger(); //global object to print;

///return true if text is full of spaces only.
bool isAllSpaces(String text) {
  return text.replaceAll(" ", "").length == 0;
}
