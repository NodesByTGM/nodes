import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nodes/config/dependencies.dart';

class PushNotification {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  PushNotification(this._flutterLocalNotificationsPlugin);

  init(Function(RemoteMessage) onMessage) async {
    //
    if (Platform.isIOS) {
      String? apnsToken = await _firebaseMessaging.getAPNSToken();
      if (apnsToken != null) {
        // await _firebaseMessaging.subscribeToTopic("notificationChannel");
        try {
          await _firebaseMessaging.subscribeToTopic('notificationChannel');
        } on FirebaseException catch (e) {
          debugPrint("George here is the error: $e");
        }
      } else {
        await Future<void>.delayed(const Duration(seconds: 3));
        apnsToken = await _firebaseMessaging.getAPNSToken();
        if (apnsToken != null) {
          try {
            await _firebaseMessaging.subscribeToTopic('notificationChannel');
          } on FirebaseException catch (e) {
            debugPrint("George here is the error: $e");
          }
        }
      }
    } else {
      try {
        await _firebaseMessaging.subscribeToTopic('notificationChannel');
      } on FirebaseException catch (e) {
        debugPrint("George here is the error: $e");
      }
    }

    //

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        onMessage(message);
      }
    });

    // FirebaseMessaging.onMessage
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        pushNotification(
          notification.hashCode,
          notification.title!,
          notification.body!,
          payload: jsonEncode(message.toMap()),
        );
      }
    });

    // FirebaseMessaging.onMessageOpenedApp
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      onMessage(message);
    });
  }

  // subscribeTopic Method
  subscribeTopic(String topic, [bool unSubscribe = false]) async {
    if (unSubscribe) {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      return;
    }
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  initLocalNotification(
      SelectNotificationCallback onAndroidNotification,
      // NotificationResponse onAndroidNotification,
      DidReceiveLocalNotificationCallback
          onDidReceivedLocalNotification) async {
    // Android Setup
    var initAndroidSettings =
        const AndroidInitializationSettings('@mipmap/launcher_icon');

    // iOS Setup
    var initIOSSettings = const IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Initializing both Android & iOS Setup
    var initSettings = InitializationSettings(
      android: initAndroidSettings,
      iOS: initIOSSettings,
    );

    //Initializing the LocalNotification Plugin
    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onSelectNotification: onAndroidNotification,
    );
  }

  pushNotification(int id, String title, String body, {String? payload}) async {
    NotificationDetails platformChannelSpecifics;
    if (Platform.isIOS) {
      const iosPlatformChannelSpecifics = IOSNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );
      platformChannelSpecifics =
          const NotificationDetails(iOS: iosPlatformChannelSpecifics);
    } else {
      platformChannelSpecifics =
          NotificationDetails(android: _notificationDetails);
    }
    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
    // .show(id, title, body, _platformChannelSpecifics, payload: payload);
  }

  AndroidNotificationDetails get _notificationDetails {
    final channel = locator.get<AndroidNotificationChannel>();
    return AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelShowBadge: true,
      playSound: true,
      priority: Priority.max,
      showWhen: true,
      channelDescription: 'Receive updates and other notifications from Nodes',
      subText: "Nodes: Talent's Home",
    );
  }
}

setupNotification() async {
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: true,
    sound: true,
  );
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // debugPrint("George here is the FCM token $fcmToken");
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await FirebaseMessaging.instance.requestPermission(provisional: true);
  if (Platform.isAndroid) {
    await locator
        .get<FlutterLocalNotificationsPlugin>()
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(locator.get<AndroidNotificationChannel>());
  }

  debugPrint('User granted permission: ${settings.authorizationStatus}');
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  // debugPrint("Handling a background message: ${message.messageId}");
  debugPrint("George Handling a background message: ${message.data}");
  debugPrint(
      "George Handling a background message: ${message.notification?.body}");
  debugPrint(
      "George Handling a background message: ${message.notification?.title}");
}
