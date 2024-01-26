import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/models/current_session.dart';
import 'package:nodes/core/services/push_notifications.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/home/views/navbar_view.dart';
import 'package:nodes/features/auth/views/welcome_back_screen.dart';
import 'package:nodes/features/home/views/welcome_screen.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';
import 'package:upgrader/upgrader.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const String routeName = '/';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late AuthController _authController;
  // final _localPushService = locator<PushNotification>();

  // _initMessaging() async {
  //   await _localPushService.init(_handlePushNotification);
  //   await _localPushService.initLocalNotification(
  //     _handleLocalAndroidPushNotification,
  //     _handleLocalIOSPushNotification,
  //   );
  // }

  // _handlePushNotification(RemoteMessage message) {
  //   if (mounted) {
  //     final body = message.notification?.body;
  //     debugPrint(
  //         "George this is the notification _handlePushNotification::: $body");
  //   }
  // }

  // Future<void> _handleLocalAndroidPushNotification(String? payload) async {
  //   if (payload != null) {
  //     debugPrint(
  //         'George this is the notification _handleLocalAndroidPushNotification::: Notification payload: $payload');
  //   }
  // }

  // Future _handleLocalIOSPushNotification(
  //     int id, String? title, String? body, String? payload) async {
  //   if (payload != null) {
  //     debugPrint(
  //         'George this is the notification _handleLocalIOSPushNotification::: Notification payload: $payload');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // _authController = context.read<AuthController>();
    _authController = locator.get<AuthController>();
    if (mounted) {
      // _initMessaging();
    }
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      upgrader: Upgrader(
        dialogStyle: Platform.isIOS
            ? UpgradeDialogStyle.cupertino
            : UpgradeDialogStyle.material,
      ),
      child: _getHomeWidget(),
    );
  }

  Widget _getHomeWidget() {
    switch (_authController.currentScreen) {
      case NavbarView.routeName:
        return FutureBuilder<CurrentSession?>(
          future: _authController.currentSession,
          builder: (context, snapshot) {
            if (ConnectionState.done != snapshot.connectionState) {
              return const Scaffold(
                body: Loader(),
              );
            }
            if (snapshot.data == null) {
              // check if you're has ever created account before, then show the welcomebackscreen
              return const WelcomeScreen();
            }
            return const NavbarView();
          },
        );
      default:
        return const WelcomeScreen();
      // return const WelcomeBackScreen();
    }
  }
}
