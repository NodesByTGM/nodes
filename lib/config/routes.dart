// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:nodes/features/auth/views/business_auth/business_auth_screen.dart';
import 'package:nodes/features/auth/views/business_auth/business_signup_screen.dart';
import 'package:nodes/features/auth/views/business_auth/business_stepper_wrapper.dart';
import 'package:nodes/features/auth/views/general_signup_screen.dart';
import 'package:nodes/features/auth/views/otp_screen.dart';
import 'package:nodes/features/auth/views/talent_auth/talent_stepper_wrapper.dart';
import 'package:nodes/features/auth/views/talent_auth/talent_auth_screen.dart';
import 'package:nodes/features/auth/views/talent_auth/talent_signup_screen.dart';
import 'package:nodes/features/home/views/home_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    debugPrint('Current route name ${settings.name}');

    final args = settings.arguments;
    switch (settings.name) {
      case HomeView.routeName:
        const page = HomeView();
        return MaterialPageRoute(
          builder: (_) => page,
        );
      case GeneralSignupScreen.routeName:
        const page = GeneralSignupScreen();
        return MaterialPageRoute(
          builder: (_) => page,
        );
      case TalentAuthScreen.routeName:
        const page = TalentAuthScreen();
        return MaterialPageRoute(
          builder: (_) => page,
        );
      case TalentSignupScreen.routeName:
        const page = TalentSignupScreen();
        return MaterialPageRoute(
          builder: (_) => page,
        );
      case OtpScreen.routeName:
        // pass data: From route, to route and generic data <T>
        const page = OtpScreen();
        return MaterialPageRoute(
          builder: (_) => page,
        );
      case TalentStepperWrapperScreen.routeName:
        const page = TalentStepperWrapperScreen();
        return MaterialPageRoute(
          builder: (_) => page,
        );
      case BusinessAuthScreen.routeName:
        const page = BusinessAuthScreen();
        return MaterialPageRoute(
          builder: (_) => page,
        );
      case BusinessSignupScreen.routeName:
        const page = BusinessSignupScreen();
        return MaterialPageRoute(
          builder: (_) => page,
        );
      case BusinessStepperWrapperScreen.routeName:
        const page = BusinessStepperWrapperScreen();
        return MaterialPageRoute(
          builder: (_) => page,
        );

      // case CreateEditVerificationScreen.routeName:
      //   final page = CreateEditVerificationScreen(
      //     createEditData: args as CreateEditModel,
      //   );
      //   return MaterialPageRoute(builder: (_) => page);

      // case ResponseHistoryScreen.routeName:
      //   final page = ResponseHistoryScreen(data: args as VerificationModel);
      //   return MaterialPageRoute(
      //     builder: (_) => page,
      //     fullscreenDialog: true,
      //   );
      default:
        const page = HomeView();
        return MaterialPageRoute(builder: (_) => page);
    }
  }
}
