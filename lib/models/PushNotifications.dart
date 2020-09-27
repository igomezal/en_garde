import 'package:en_garde/models/DatabaseService.dart';
import 'package:en_garde/models/NotificationStored.dart';
import 'package:en_garde/models/NotificationsDatabase.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
  print(message);
  // Or do other work.
}

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init(String uid, BuildContext context) async {
    var platform = Theme.of(context).platform;
    if (!_initialized && platform != TargetPlatform.iOS) {
      await _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
          NotificationsDatabase().addNotification(NotificationStored(
              title: message['data']['title'],
              body: message['data']['body'],
              timestamp: message['data']['timestamp']));
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          NotificationsDatabase().addNotification(NotificationStored(
              title: message['data']['title'],
              body: message['data']['body'],
              timestamp: message['data']['timestamp']));
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
          NotificationsDatabase().addNotification(NotificationStored(
              title: message['data']['title'],
              body: message['data']['body'],
              timestamp: message['data']['timestamp']));
        },
        onBackgroundMessage: myBackgroundMessageHandler,
      );

      _initialized = true;

      String token = await _firebaseMessaging.getToken();

      if (token != null) {
        DatabaseService().changeNotificationToken(uid, token);
      }
    }
  }

  void finish(String uid) {
    if (_initialized) {
      _initialized = false;
      DatabaseService().changeNotificationToken(uid, null);
      _firebaseMessaging.deleteInstanceID();
    }
  }
}
