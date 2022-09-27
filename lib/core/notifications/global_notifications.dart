import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../res/routes_manager.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // showNotification(message, "${message.data}");
}

void requestPermissions() {
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}

showNotification(RemoteMessage event, String payload) async {
  var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
      presentAlert: true, presentBadge: true, presentSound: true);
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'com.Buyex.Provider.urgent', 'iyilikSepti', // Bundle Id of Project
    color: Colors.red,
    icon: 'notificationlogo', // Logo of app change in assets
    importance: Importance.high,
    priority: Priority.high,
  );
  var notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  String title = "${event.notification!.title}";
  String body = "${event.notification!.body}";

  await flutterLocalNotificationsPlugin
      .show(200, title, body, notificationDetails, payload: payload);
}

initlocalNotification(context) async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings(
          'notificationlogo'); // Logo of app change in assets

  const IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) =>
          handleNotificationsTap(payload, context));
}

Future<void> registerNotification() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );
}

// Define an async function to initialize FlutterFire
Future<void> initializeFlutterFire() async {
  // Wait for Firebase to initialize
  await registerNotification();
}

handleNotificationsTap(String? payload, context) async {
  log('payloadddddddddddddd $payload');
  // var data = payload as Map;

  if (payload!.isEmpty || payload == '{}') {
    Navigator.pushReplacementNamed(context, Routes.intro);
    List<String> str =
        payload.replaceAll("{", "").replaceAll("}", "").split(",");
    log('str. $str');
    Map<String, dynamic> data = {};
    for (int i = 0; i < str.length; i++) {
      List<String> s = str[i].split(":");
      data.putIfAbsent(s[0].trim(), () => s[1].trim());
      log('data. $data');
    }
    log('data aftr parse. ${data[0]}');
    String modelType = data['model_type'];
    var modelId = data['model_id'];
    var pageId = data['page_id'];
    log('modelType $modelType modelId $modelId  pageId$pageId ');

    // Handle Navigate in App
    if (modelType == 'custom' && modelId != null) {
      Navigator.pushReplacementNamed(context, Routes.intro); // ToDo

    } else if (modelType == 'close_to_end' || modelType == 'your_offer_ended') {
      Navigator.pushReplacementNamed(context, Routes.intro); // ToDo
    } else {
      Navigator.pushReplacementNamed(context, Routes.intro); // ToDo
    }
  }
}
