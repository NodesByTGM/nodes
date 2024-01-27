import 'package:nodes/features/auth/views/business_auth/business_auth_screen.dart';
import 'package:nodes/features/auth/views/general_signup_screen.dart';
import 'package:nodes/features/auth/views/talent_auth/talent_auth_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static const String routeName = "/welcomeScreen";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          width: screenWidth(context),
          height: screenHeight(context),
          padding: screenPadding,
          child: SafeArea(
            child: Column(
              children: [
                ySpace(height: 40),
                Image.asset(
                  ImageUtils.appIcon,
                  fit: BoxFit.cover,
                  height: 32,
                  width: 36,
                ),
                ySpace(),
                labelText(
                  "Your creative evolution starts here!",
                  fontSize: 24,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                ),
                ySpace(height: 8),
                subtext(
                  "Sign up now and become part of the Nodes community.",
                  fontSize: 14,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                ),
                ySpace(height: 40),
                OutlineBtn(
                  onPressed: () {},
                  leftIcon: SvgPicture.asset(ImageUtils.googleIcon),
                  borderColor: BLACK,
                  child: btnTxt("Sign up with Google"),
                ),
                ySpace(height: 8),
                OutlineBtn(
                  onPressed: () {},
                  leftIcon: SvgPicture.asset(ImageUtils.appleIcon),
                  borderColor: BLACK,
                  child: btnTxt("Sign up with Apple"),
                ),
                ySpace(height: 40),
                SvgPicture.asset(
                  ImageUtils.orText,
                  width: screenWidth(context),
                ),
                ySpace(height: 40),
                SubmitBtn(
                  onPressed: () {
                    navigateTo(
                      context,
                      // GeneralSignupScreen.routeName,
                      TalentAuthScreen.routeName,
                      // BusinessAuthScreen.routeName,
                    );
                  },
                  title: btnTxt("Continue with email", WHITE),
                ),
                ySpace(height: 32),
                Wrap(
                  spacing: 2,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    tosText(
                      "By creating an account you agree with our",
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: tosText(
                        "Terms of Service,",
                        isUnderlined: true,
                      ),
                    ),
                    tosText(
                      "and",
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: tosText(
                        "Privacy Policy.",
                        isUnderlined: true,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Wrap(
                  spacing: 2,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    labelText(
                      "Already have an account?",
                      fontSize: 16,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w400,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: labelText(
                        "Log In",
                        fontSize: 16,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w400,
                        color: PRIMARY,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
