// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:nodes/features/auth/views/business_auth/business_auth_screen.dart';
import 'package:nodes/features/auth/views/business_auth/business_signup_screen.dart';
import 'package:nodes/features/auth/views/business_auth/business_stepper_wrapper.dart';
import 'package:nodes/features/auth/views/forgot_password_screen.dart';
import 'package:nodes/features/auth/views/general_signup_screen.dart';
import 'package:nodes/features/auth/views/otp_screen.dart';
import 'package:nodes/features/auth/views/price_plan_screen.dart';
import 'package:nodes/features/auth/views/talent_auth/talent_stepper_wrapper.dart';
import 'package:nodes/features/auth/views/talent_auth/talent_auth_screen.dart';
import 'package:nodes/features/auth/views/talent_auth/talent_signup_screen.dart';
import 'package:nodes/features/auth/views/welcome_back_screen.dart';
import 'package:nodes/features/home/views/home_screen.dart';
import 'package:nodes/features/home/views/navbar_view.dart';
import 'package:nodes/features/messages/screen/message_screen.dart';
import 'package:nodes/features/messages/screen/single_message_details.dart';
import 'package:nodes/features/notification/screen/notification_screen.dart';

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
      case ForgotPasswordScreen.routeName:
        const page = ForgotPasswordScreen();
        return MaterialPageRoute(
          builder: (_) => page,
        );
      case WelcomeBackScreen.routeName:
        const page = WelcomeBackScreen();
        return MaterialPageRoute(
          builder: (_) => page,
        );
      case GeneralSignupScreen.routeName:
        const page = GeneralSignupScreen();
        return MaterialPageRoute(
          builder: (_) => page,
        );
      case PricePlanScreen.routeName:
        const page = PricePlanScreen();
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
        final page = OtpScreen(
          otpData: args as OtpScreenData,
        );
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

      case NavbarView.routeName:
        const page = NavbarView();
        return MaterialPageRoute(
          builder: (_) => page,
        );

      case NotificationScreen.routeName:
        const page = NotificationScreen();
        return MaterialPageRoute(
          builder: (_) => page,
        );

      case MessageScreen.routeName:
        const page = MessageScreen();
        return MaterialPageRoute(
          builder: (_) => page,
        );

      case SingleMessageDetails.routeName:
        const page = SingleMessageDetails();
        return MaterialPageRoute(
          builder: (_) => page,
          fullscreenDialog: true,
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
