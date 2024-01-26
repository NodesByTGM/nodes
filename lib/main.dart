import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/core/services/local_storage.dart';
import 'package:nodes/core/services/push_notifications.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/utilities/constants/constant_strings.dart';
import 'package:nodes/utilities/utils/themes.dart';
import 'package:nodes/config/routes.dart';
import 'package:nodes/features/home/views/home_screen.dart';
import 'package:provider/provider.dart';

late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  // await Firebase.initializeApp();
  await LocalStorageService.initializeDb();
  setUpLocator();
  _setupLogging();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // //  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };
  // await setupNotification();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>(
          create: (_) => locator.get<AuthController>(),
        ),
         ChangeNotifierProvider<NavController>(
          create: (_) => locator.get<NavController>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: themeData(),
        home: const HomeView(),
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) async {
    var log =
        '${rec.level.name}: ${rec.time} <:::::> [${rec.loggerName}] ${rec.sequenceNumber} : ${rec.message}';
    debugPrint(log);
  });
}

void logError(String code, String? message) {
  if (message != null) {
    debugPrint('Error: $code\nError Message: $message');
  } else {
    debugPrint('Error: $code');
  }
}
