import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  //keys
  static String USER_ID = "user.id";
  static String USER_NAME = "user.name";
  static String DISPLAY_NAME = "user.display";
  static String USER_IMAGE = "user.image";
  static String TOKEN = "user.token";
  static String SESSION = "user.session";
  static String IsFirstTime = "user.isFirstTime";

  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static setUserID(String id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_ID, id);
  }

  static Future<String> getUserID() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(USER_ID) ?? "";
  }

  static setUserName(String cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_NAME, cookie);
  }

  static Future<String> getUserName() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(USER_NAME) ?? "";
  }

  static setDisplayName(String cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(DISPLAY_NAME, cookie);
  }

  static Future<String> getDisplayName() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(DISPLAY_NAME) ?? "";
  }

  static setUserImage(String cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_IMAGE, cookie);
  }

  static Future<String> getUserImage() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(USER_IMAGE) ?? "";
  }

  static setUserToken(String cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKEN, cookie);
  }

  static Future<String> getUserToken() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(TOKEN) ?? "";
  }

  static setLoginSession(bool cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(SESSION, cookie);
  }

  static Future<bool> getLoginSession() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getBool(SESSION) ?? false;
  }

  Future<bool> isFirstTimeMakingComp2() async {
    SharedPreferences prefs = await _prefs;
    var isFirstTime = prefs.getBool(IsFirstTime);
    if (isFirstTime != null && !isFirstTime) {
      //Not first time.
      prefs.setBool(IsFirstTime, false);
      return false;
    } else {
      // First time.
      prefs.setBool(IsFirstTime, false);
      return true;
    }
  }
}
