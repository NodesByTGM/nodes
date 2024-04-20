import 'dart:io';

import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/auth/views/forgot_password_screen.dart';
import 'package:nodes/features/auth/views/talent_auth/talent_stepper_wrapper.dart';
import 'package:nodes/features/home/views/navbar_view.dart';
import 'package:nodes/features/home/views/welcome_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class WelcomeBackScreen extends StatefulWidget {
  const WelcomeBackScreen({Key? key}) : super(key: key);

  static const String routeName = "/welcomeBackScreen";

  @override
  State<WelcomeBackScreen> createState() => _WelcomeBackScreenState();
}

class _WelcomeBackScreenState extends State<WelcomeBackScreen> {
  late AuthController authCtrl;
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController pwdCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final formValues = {};
  bool isPwd = false;

  @override
  void initState() {
    authCtrl = locator.get<AuthController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
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
                  "Welcome Back!",
                  fontSize: 24,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
                ySpace(height: 8),
                subtext(
                  "Sign in to your creative space.",
                  fontSize: 14,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                ),
                ySpace(height: 40),
                OutlineBtn(
                  onPressed: signupWithGoogle,
                  leftIcon: SvgPicture.asset(ImageUtils.googleIcon),
                  borderColor: BLACK,
                  child: btnTxt("Sign in with Google"),
                ),
                ySpace(height: 8),
                if (Platform.isIOS) ...[
                  OutlineBtn(
                    onPressed: signupWithApple,
                    leftIcon: SvgPicture.asset(ImageUtils.appleIcon),
                    borderColor: BLACK,
                    child: btnTxt("Sign in with Apple"),
                  ),
                ],
                ySpace(height: 40),
                SvgPicture.asset(
                  ImageUtils.orSignInWIthEmailText,
                  width: screenWidth(context),
                ),
                ySpace(height: 40),
                FormBuilder(
                  key: formKey,
                  child: Column(
                    children: [
                      FormWithLabel(
                        label: "Username or Email address",
                        form: FormBuilderTextField(
                          name: "username_email",
                          decoration: FormUtils.formDecoration(
                            hintText: "Enter your username or email address",
                          ),
                          keyboardType: TextInputType.emailAddress,
                          style: FORM_STYLE,
                          controller: emailCtrl,
                          onSaved: (value) =>
                              formValues['email'] = trimValue(value),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context,
                                errorText: Constants.emailError),
                            FormBuilderValidators.email(context,
                                errorText: Constants.emailInvalid),
                          ]),
                          onChanged: (val) {
                            // _checActiveBtnColor();
                          },
                        ),
                      ),
                      FormUtils.formSpacer(),
                      FormWithLabel(
                        label: "Password",
                        secondaryLabel: GestureDetector(
                          onTap: () {
                            navigateTo(context, ForgotPasswordScreen.routeName);
                          },
                          child: subtext(
                            "Forgot?",
                            fontSize: 14,
                            color: PRIMARY,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        form: FormBuilderTextField(
                          name: "password",
                          decoration: FormUtils.formDecoration(
                            hintText: "Enter password",
                            suffixIcon: InkWell(
                              onTap: () {
                                isPwd = !isPwd;
                                setState(() {});
                              },
                              child: Icon(
                                isPwd ? Icons.visibility_off : Icons.visibility,
                                color: GRAY,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          style: FORM_STYLE,
                          controller: pwdCtrl,
                          onSaved: (value) =>
                              formValues['password'] = trimValue(value),
                          obscureText: !isPwd,
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(
                                context,
                                errorText: Constants.passwordError,
                              ),
                            ],
                          ),
                          onChanged: (val) {
                            // _checActiveBtnColor();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                ySpace(height: 24),
                SubmitBtn(
                  onPressed: _submit,
                  // onPressed: () {
                  //   // Test Purpose...
                  //   navigateTo(context, PricePlanScreen.routeName);
                  // },
                  title: btnTxt("Sign In", WHITE),
                  loading: authCtrl.loading,
                ),
                const Spacer(),
                Wrap(
                  spacing: 2,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    labelText(
                      "New to Nodes?",
                      fontSize: 16,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w400,
                    ),
                    GestureDetector(
                      onTap: () {
                        navigateTo(context, WelcomeScreen.routeName);
                      },
                      child: labelText(
                        "Sign Up",
                        fontSize: 16,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w400,
                        color: PRIMARY,
                      ),
                    ),
                  ],
                ),
                ySpace(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() async {
    closeKeyPad(context);
    // navigateTo(context, NavbarView.routeName); // Uncomment for testings only
    if (formKey.currentState!.saveAndValidate()) {
      UserModel? user = await authCtrl.login(
        {
          // "email": "napor44764@abnovel.com", lopodaf334@kravify.com  // currently a business account
          // "password": "Test@1234",
          // "email": "niweb33325@nimadir.com", // currently a talent account
          // "password": "Test@1234",
          // "email": "liniyi2985@acname.com", // currently a standard account
          // "password": "Test@1234",
          // "email": "petowo6181@abnovel.com", // currently a standard account
          // "password": "Test@1234",
          "email": emailCtrl.text,
          "password": pwdCtrl.text,
        },
      );
      // var res = "";
      // if (!res) {
      //   // Using this to mitidate the 'Retrying request' alert i'd set in my exception file...
      //   showError(message: "You Provided an Invalid Credentials");
      //   return;
      // }
      if (!isObjectEmpty(user) && mounted) {
        safeNavigate(() {
          formKey.currentState!.reset();
          context.read<NavController>().resetPageListStack();
          // Check where and if the user has an incomplete onboarding process
          if (user?.step == 5) {
            // Meaning, user completed the onboarding process...
            navigateAndClearPrev(context, NavbarView.routeName);
          } else {
            // User needs to be redirected to the next onboarding section after his current state..
            authCtrl.setTStepper(
              user?.step == 0 ? user!.step : (user!.step + 1),
            );
            showText(message: "Please complete your On-boarding process");
            navigateTo(context, TalentStepperWrapperScreen.routeName);
            // This means, advance a bit than the user's current step if they'd passed the initial step (being 0)
          }
        });
      }
    }
  }

  @override
  void dispose() {
    pwdCtrl.dispose();
    emailCtrl.dispose();
    super.dispose();
  }

  void signupWithGoogle() async {
    await authCtrl.signUpWithGoogle(context);
  }

  void signupWithApple() async {}
}
