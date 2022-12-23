// import 'dart:io';
// import 'package:Persona/app/Globals.dart';
// import 'package:Persona/app/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class FirebaseServices {
//   static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//   static final _fln = FlutterLocalNotificationsPlugin();
//   int _counter = 0;

//   Future<String> getFCMToken() async {
//     return await _firebaseMessaging.getToken();
//   }

//   static Future<void> init() async {
//     var token = _firebaseMessaging.getToken();
//     mLogger.i("FCMtoken: ${await _firebaseMessaging.getToken()}");

//     _firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         mLogger.i("onMessage: $message");
//         // _showNotificationWithDefaultSound(message);
//         _serialiseAndNavigate(message);
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         mLogger.i("onLaunch: $message");

//         _serialiseAndNavigate(message);
//       },
//       onResume: (Map<String, dynamic> message) async {
//         mLogger.i("onResume: $message");

//         _serialiseAndNavigate(message);
//       },
//     );
//   }

//   static Future initialiseLocalNotification() async {
//     /////// flutter local notification
//     // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     var android = AndroidInitializationSettings('ic_logo');
//     var iOS = IOSInitializationSettings();
//     var platform = InitializationSettings(android: android, iOS: iOS);
//     await _fln.initialize(platform, onSelectNotification: onSelectNotification);
//   }

//   //
//   static void _serialiseAndNavigate(Map<String, dynamic> message) {
//     var notificationData = message['data'];
//     var model = notificationData['view'];
//     mLogger.d("___model: $model");
//     // _goToNotifications();
//   }

//   Future _showNotificationWithDefaultSound(Map<String, dynamic> message) async {
//     var notificationData = message['data'];
//     mLogger.d("notificationData: $notificationData");
//     var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//       'default_notification_channel_id',
//       'default_notification_channel_id',
//       'your channel description',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//     var platformChannelSpecifics = new NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//     await _fln.show(
//       _counter++,
//       '${message['notification']['title']}',
//       '${message['notification']['body']}',
//       platformChannelSpecifics,
//       payload: "notificationData",
//     );
//   }

//   static Future onSelectNotification(dynamic payload) async {
//     if (payload != null) {
//       mLogger.d('___notification payload: ' + payload);
//       _serialiseAndNavigate(payload);
//     }
//   }

//   // static void _goToNotifications() {
//   //   //this is like navigate to just without using context.
//   //   Get.to(NotificationsPage());
//   // }
// }
