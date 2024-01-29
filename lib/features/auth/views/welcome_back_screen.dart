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
                  fontWeight: FontWeight.w600,
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
                        secondaryLabel: subtext(
                          "Forgot?",
                          fontSize: 14,
                          color: PRIMARY,
                          fontWeight: FontWeight.w400,
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
                  title: btnTxt("Sign In", WHITE),
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
                      onTap: () {},
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() async {
    closeKeyPad(context);
    if (formKey.currentState!.saveAndValidate()) {
      // LoginResponse? response =
      //     await context.read<AuthController>().signIn(_request);
      var response = "";

      if (!isObjectEmpty(response) && mounted) {
        safeNavigate(() {
          formKey.currentState!.reset();
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
    super.dispose();
  }
}
