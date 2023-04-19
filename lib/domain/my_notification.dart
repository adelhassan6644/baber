import 'dart:developer';
import 'package:baber/navigation/custom_navigation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../app/core/api/end_points.dart';
import '../navigation/routes.dart';

class MyNotification {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationsSettings =
    InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onSelectNotification: (String? payload) async {
          try {
            if (payload != null && payload.isNotEmpty) {
             CustomNavigator.push(Routes.NOTIFICATION);
            }
          } catch (e) {}

          return;
        });
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    await FirebaseMessaging.instance.subscribeToTopic(EndPoints.topic);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("onMessage: ${message.data}");
      MyNotification.showNotification(
          message.data, flutterLocalNotificationsPlugin);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("onMessageApp: ${message.data}");
      MyNotification.showNotification(
          message.data, flutterLocalNotificationsPlugin);
    });
  }

  static Future<void> showNotification(
      Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
    if (message['image'] != null && message['image'].isNotEmpty) {
      try {
        await showBigPictureNotificationHiddenLargeIcon(message, fln);
      } catch (e) {
        await showBigTextNotification(message, fln);
      }
    } else {
      await showBigTextNotification(message, fln);
    }
  }

  static Future<void> showTextNotification(
      Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
    String _title = message['title'] ?? "Baber";
    String _body = message['body'] ?? " Notification";
    // String _orderID = message['id'];
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your channel id', 'your channel name',
      // 'your channel name',
      // sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max, priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(
      0,
      _title,
      _body,
      platformChannelSpecifics,
    );
  }

  static Future<void> showBigTextNotification(
      Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
    String _title = message['title'] ?? "Baber";
    String _body = message['body'] ?? " Notification";
    // String _orderID = message['id'];
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      _body,
      htmlFormatBigText: true,
      contentTitle: _title,
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'big text channel id', 'your channel name',
      // 'big text channel name',
      importance: Importance.max,
      styleInformation: bigTextStyleInformation, priority: Priority.high,
      // sound: RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(
      0,
      _title,
      _body,
      platformChannelSpecifics,
    );
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(
      Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
    String _title = message['title'] ?? "Baber";
    String _body = message['body'] ?? " Notification";
    // String _orderID = message['id'];

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'big text channel id', 'your channel name',
      // 'big text channel name',
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(
      0,
      _title,
      _body,
      platformChannelSpecifics,
    );
  }

}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  var androidInitialize = const AndroidInitializationSettings('notification_icon');
  var iOSInitialize = const IOSInitializationSettings();
  var initializationsSettings =
  InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  MyNotification.showNotification(
      message.data, flutterLocalNotificationsPlugin);
}
