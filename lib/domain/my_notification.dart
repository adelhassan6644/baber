import 'dart:developer';
import 'package:baber/app/core/api/end_points.dart';
import 'package:baber/navigation/custom_navigation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../navigation/routes.dart';

class MyNotification {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings(
        '@drawable/notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
    InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        // onSelectNotification: (String? payload) async {
        //     if (payload != null && payload.isNotEmpty) {
        //       CustomNavigator.push(Routes.NOTIFICATION);}
        //
        //   return;
        // }
        );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
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

  static Future<void> showNotification(Map<String, dynamic> message,
      FlutterLocalNotificationsPlugin fln) async {
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

  static Future<void> showTextNotification(Map<String, dynamic> message,
      FlutterLocalNotificationsPlugin fln) async {
    String title = message['title'] ?? "Baber";
    String body = message['body'] ?? " Notification";
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your channel id', 'your channel name',
      importance: Importance.high,
      priority: Priority.high,);
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  static Future<void> showBigTextNotification(Map<String, dynamic> message,
      FlutterLocalNotificationsPlugin fln) async {
    String title = message['title'] ?? "Baber";
    String body = message['body'] ?? " Notification";
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'big text channel id', 'your channel name',
      importance: Importance.max,
      styleInformation: bigTextStyleInformation, priority: Priority.high,
    );
    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(
      Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
    String title = message['title'] ?? "Baber";
    String body = message['body'] ?? " Notification";
    // String _orderID = message['id'];

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'big text channel id', 'your channel name',
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

}

@pragma('vm:entry-point')
Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  log('background: ${message.data}');
  var androidInitialize = const AndroidInitializationSettings('@drawable/notification_icon');
  var iOSInitialize = const DarwinInitializationSettings();
  var initializationsSettings =
  InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  MyNotification.showNotification(
      message.data, flutterLocalNotificationsPlugin);
}