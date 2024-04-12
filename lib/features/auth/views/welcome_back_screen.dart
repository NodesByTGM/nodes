import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/auth/views/forgot_password_screen.dart';
import 'package:nodes/features/auth/views/price_plan_screen.dart';
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
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController pwdCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final formValues = {};
  bool isPwd = false;

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
                  loading: context.watch<AuthController>().loading,
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
      bool res = await context.read<AuthController>().login(
        {
          // "email": "niweb33325@nimadir.com", // currently a talent account
          // "password": "Test@1234",
          // "email": "liniyi2985@acname.com", // currently a standard account
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
      if (res && mounted) {
        safeNavigate(() {
          formKey.currentState!.reset();
          navigateAndClearPrev(context, NavbarView.routeName);
          // if (response!.route == VerifyAccount.route) {
          //   navigateAndClearPrev(
          //     context,
          //     VerifyAccount.route,
          //     arguments: VerifyData(
          //       email: _request.email,
          //       nextRoute: NavbarView.routeName,
          //     ),
          //   );
          //   return;
          // }
          // navigateAndClearPrev(context, response.route);
          // context.read<AuthController>().resetVisibility();
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
}
