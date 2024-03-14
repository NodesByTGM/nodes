import 'package:nodes/features/auth/views/business_auth/business_auth_screen.dart';
import 'package:nodes/features/auth/views/otp_screen.dart';
import 'package:nodes/features/auth/views/talent_auth/talent_stepper_wrapper.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class TalentSignupScreen extends StatefulWidget {
  const TalentSignupScreen({Key? key}) : super(key: key);

  static const String routeName = "/talentSignupScreen";

  @override
  State<TalentSignupScreen> createState() => _TalentSignupScreenState();
}

class _TalentSignupScreenState extends State<TalentSignupScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController fullnameCtrl = TextEditingController();
  final TextEditingController pwdCtrl = TextEditingController();

  final formValues = {};
  bool isPwd = false;

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      isCancel: false,
      title: Image.asset(
        ImageUtils.appIcon,
        fit: BoxFit.cover,
        height: 32,
        width: 36,
      ),
      body: Column(
        children: [
          ySpace(),
          labelText(
            "Are you a Talent?",
            fontSize: 24,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
          ),
          ySpace(height: 8),
          subtext(
            "Lorem ipsum dolor sit amet adipiscing elit.",
            fontSize: 14,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w400,
          ),
          ySpace(height: 40),
          Wrap(
            spacing: 2,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              labelText(
                "Already using Nodes?",
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
          ySpace(height: 40),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FormBuilder(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormWithLabel(
                          label: "Full name*",
                          form: FormBuilderTextField(
                            name: "fullname",
                            decoration: FormUtils.formDecoration(
                              hintText: "Enter your full name",
                            ),
                            keyboardType: TextInputType.text,
                            style: FORM_STYLE,
                            controller: fullnameCtrl,
                            // initialValue: "John Doe",
                            onSaved: (value) =>
                                formValues['fullname'] = trimValue(value),
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                  context,
                                  errorText: Constants.emptyFieldError,
                                ),
                              ],
                            ),
                            onChanged: (val) {},
                          ),
                        ),
                        FormUtils.formSpacer(),
                        FormWithLabel(
                          label: "Email address*",
                          form: FormBuilderTextField(
                            name: "email",
                            decoration: FormUtils.formDecoration(
                              hintText: "Enter email address",
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: FORM_STYLE,
                            controller: emailCtrl,
                            // initialValue: "janedoe@gmail.com",
                            onSaved: (value) =>
                                formValues['email'] = trimValue(value),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                context,
                                errorText: Constants.emailError,
                              ),
                              FormBuilderValidators.email(
                                context,
                                errorText: Constants.emailInvalid,
                              ),
                            ]),
                            onChanged: (val) {
                              // _checActiveBtnColor();
                            },
                          ),
                        ),
                        FormUtils.formSpacer(),
                        FormWithLabel(
                          label: "Re-enter password",
                          form: FormBuilderTextField(
                            name: "password",
                            decoration: FormUtils.formDecoration(
                              hintText: "Re-enter your password",
                              suffixIcon: InkWell(
                                onTap: () {
                                  isPwd = !isPwd;
                                  setState(() {});
                                },
                                child: Icon(
                                  isPwd
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: GRAY,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: FORM_STYLE,
                            controller: pwdCtrl,
                            onSaved: (value) =>
                                formValues['password'] = trimValue(value),
                            obscureText: !isPwd,
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                  context,
                                  errorText: Constants.emptyFieldError,
                                ),
                              ],
                            ),
                            onChanged: (val) {
                              setState(() {});
                            },
                          ),
                        ),
                        ySpace(height: 24),
                        SubmitBtn(
                          onPressed: _submit,
                          title: btnTxt(Constants.continueText, WHITE),
                        ),
                      ],
                    ),
                  ),
                  ySpace(height: 24),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        navigateAndClearPrev(
                          context,
                          BusinessAuthScreen.routeName,
                        );
                      },
                      child: labelText(
                        "Sign up as a business instead?",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
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

  void _submit() async {
    closeKeyPad(context);
    if (formKey.currentState!.saveAndValidate()) {
      navigateTo(
        context,
        OtpScreen.routeName,
        arguments: OtpScreenData(
          email: emailCtrl.text,
          from: KeyString.talentSignupScreen,
          to: TalentStepperWrapperScreen.routeName,
        ),
      );
    }
  }

  @override
  void dispose() {
    fullnameCtrl.dispose();
    emailCtrl.dispose();
    pwdCtrl.dispose();
    super.dispose();
  }
}
