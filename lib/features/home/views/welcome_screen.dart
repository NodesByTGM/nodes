import 'dart:io';

import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/auth/views/general_signup_screen.dart';
import 'package:nodes/features/auth/views/welcome_back_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static const String routeName = "/welcomeScreen";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late AuthController authCtrl;

  @override
  void initState() {
    authCtrl = locator.get<AuthController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
    // return Scaffold(
    //   backgroundColor: WHITE,
    //   body: WillPopScope(
    //     onWillPop: () async {
    //       return false;
    //     },
    //     child: Container(
    //       width: screenWidth(context),
    //       height: screenHeight(context),
    //       padding: screenPadding,
    //       child: SafeArea(
    //         child: Column(
    //           children: [
    //             ySpace(height: 40),
    //             Image.asset(
    //               ImageUtils.appIcon,
    //               fit: BoxFit.cover,
    //               height: 32,
    //               width: 36,
    //             ),
    //             ySpace(),
    //             labelText(
    //               "Nodes: Where Creatives Connect.",
    //               fontSize: 24,
    //               textAlign: TextAlign.center,
    //               fontWeight: FontWeight.w500,
    //             ),
    //             ySpace(height: 8),
    //             subtext(
    //               "Showcase your talent. Expand your opportunities.\nNetwork with like-minds.",
    //               fontSize: 14,
    //               textAlign: TextAlign.center,
    //               fontWeight: FontWeight.w400,
    //             ),
    //             ySpace(height: 40),
    //             OutlineBtn(
    //               onPressed: signupWithGoogle,
    //               leftIcon: SvgPicture.asset(ImageUtils.googleIcon),
    //               borderColor: BLACK,
    //               child: btnTxt("Sign up with Google"),
    //             ),
    //             if (Platform.isIOS) ...[
    //               // Only show for IOS Devices
    //               ySpace(height: 8),
    //               OutlineBtn(
    //                 onPressed: signupWithApple,
    //                 leftIcon: SvgPicture.asset(ImageUtils.appleIcon),
    //                 borderColor: BLACK,
    //                 child: btnTxt("Sign up with Apple"),
    //               ),
    //             ],
    //             ySpace(height: 40),
    //             SvgPicture.asset(
    //               ImageUtils.orText,
    //               width: screenWidth(context),
    //             ),
    //             ySpace(height: 40),
    //             SubmitBtn(
    //               onPressed: () {
    //                 navigateTo(
    //                   context,
    //                   GeneralSignupScreen.routeName,
    //                   // TalentAuthScreen.routeName,
    //                   // BusinessAuthScreen.routeName,
    //                 );
    //               },
    //               title: btnTxt("Continue with email", WHITE),
    //             ),
    //             ySpace(height: 32),
    //             Wrap(
    //               spacing: 2,
    //               crossAxisAlignment: WrapCrossAlignment.center,
    //               alignment: WrapAlignment.center,
    //               children: [
    //                 tosText(
    //                   "By creating an account you agree with our",
    //                 ),
    //                 GestureDetector(
    //                   onTap: () {},
    //                   child: tosText(
    //                     "Terms of Service,",
    //                     isUnderlined: true,
    //                   ),
    //                 ),
    //                 tosText(
    //                   "and",
    //                 ),
    //                 GestureDetector(
    //                   onTap: () {},
    //                   child: tosText(
    //                     "Privacy Policy.",
    //                     isUnderlined: true,
    //                     height: 1.6,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             const Spacer(),
    //             Wrap(
    //               spacing: 2,
    //               crossAxisAlignment: WrapCrossAlignment.center,
    //               children: [
    //                 labelText(
    //                   "Already have an account?",
    //                   fontSize: 16,
    //                   textAlign: TextAlign.center,
    //                   fontWeight: FontWeight.w400,
    //                 ),
    //                 GestureDetector(
    //                   onTap: () {
    //                     navigateTo(context, WelcomeBackScreen.routeName);
    //                   },
    //                   child: labelText(
    //                     "Log In",
    //                     fontSize: 16,
    //                     textAlign: TextAlign.center,
    //                     fontWeight: FontWeight.w400,
    //                     color: PRIMARY,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             ySpace(height: 20),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    // <<<< ========== Implementing the New Auth Screen, Because we wanna remove the Social Auth ============= >>>>>>>
    return Scaffold(
      backgroundColor: LIGHT_SECONDARY,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: SizedBox(
              width: screenWidth(context),
              child: Image.asset(
                ImageUtils.authBg,
                fit: BoxFit.cover,
                height: 32,
                width: 36,
              ),
            ),
          ),
          ySpace(height: 40),
          Expanded(
            child: Column(
              children: [
                labelText(
                  "Nodes: Where Creatives Connect.",
                  fontSize: 24,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
                ySpace(height: 8),
                subtext(
                  "Showcase your talent. Expand your opportunities.\nNetwork with like-minds.",
                  fontSize: 16,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          ySpace(height: 40),
          Expanded(
            child: Padding(
              padding: screenPadding,
              child: Row(
                children: [
                  Expanded(
                    child: OutlineBtn(
                      onPressed: () {
                        navigateTo(context, WelcomeBackScreen.routeName);
                      },
                      borderColor: BLACK,
                      child: btnTxt("Log In"),
                    ),
                  ),
                  xSpace(width: 16),
                  Expanded(
                    child: SubmitBtn(
                      onPressed: () {
                        navigateTo(context, GeneralSignupScreen.routeName);
                      },
                      title: btnTxt(
                        "Sign Up",
                        WHITE,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void signupWithGoogle() async {
    await authCtrl.signUpWithGoogle(context);
  }

  void signupWithApple() async {}
}
