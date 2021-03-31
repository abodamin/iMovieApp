import 'package:logger/logger.dart';

bool isLoggedIn = false;
String mUserID = "";
String mUserName = "";
String mUserToken = "";
String mDisplayName = "";
String mUserImage = "";
bool isDev = false;

Logger mLogger = Logger(); //global object to print;

///return true if text is full of spaces only.
bool isAllSpaces(String text) {
  return text.replaceAll(" ", "").length == 0;
}
