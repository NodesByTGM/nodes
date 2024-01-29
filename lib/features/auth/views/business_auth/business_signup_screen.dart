import 'package:nodes/features/auth/views/business_auth/business_stepper_wrapper.dart';
import 'package:nodes/features/auth/views/otp_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class BusinessSignupScreen extends StatefulWidget {
  const BusinessSignupScreen({Key? key}) : super(key: key);

  static const String routeName = "/businessSignupScreen";

  @override
  State<BusinessSignupScreen> createState() => _BusinessSignupScreenState();
}

class _BusinessSignupScreenState extends State<BusinessSignupScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController fullnameCtrl = TextEditingController();
  final TextEditingController companyNameCtrl = TextEditingController();
  final TextEditingController pwdCtrl = TextEditingController();

  final formValues = {};
  bool isPwd = false;
  bool tosStatus = false;

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
            "Want to register your\ncompany",
            fontSize: 24,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
          ),
          ySpace(height: 8),
          subtext(
            "You will be added as a company hiring contact",
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
                          label: "Name of company*",
                          form: FormBuilderTextField(
                            name: "business",
                            decoration: FormUtils.formDecoration(
                              hintText: "Enter the name of your company",
                            ),
                            keyboardType: TextInputType.text,
                            style: FORM_STYLE,
                            controller: companyNameCtrl,
                            // initialValue: "John Doe",
                            onSaved: (value) =>
                                formValues['company_name'] = trimValue(value),
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
                          label: "Work email address*",
                          form: FormBuilderTextField(
                            name: "email",
                            decoration: FormUtils.formDecoration(
                              hintText: "Enter work email address",
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: FORM_STYLE,
                            controller: emailCtrl,
                            // initialValue: "janedoe@gmail.com",
                            onSaved: (value) =>
                                formValues['work_email'] = trimValue(value),
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
                          label: "Password*",
                          secondaryLabel: subtext(
                            "Forgot?",
                            fontSize: 14,
                            color: PRIMARY,
                            fontWeight: FontWeight.w400,
                          ),
                          form: FormBuilderTextField(
                            name: "password",
                            decoration: FormUtils.formDecoration(
                              hintText: "Enter your password",
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: tosStatus,
                              visualDensity: VisualDensity.compact,
                              onChanged: (val) => tosClick(),
                              activeColor: PRIMARY,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => tosClick(),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Wrap(
                                    spacing: 2,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      tosText(
                                        'I verify that I am an authorized representative of this organization and have the right to act on its behalf in the creation and management of this page. The organization and I agree with Nodes ',
                                        textAlign: TextAlign.left,
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: tosText(
                                          "Terms of Service and Privacy Policy",
                                          isUnderlined: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                      onTap: () {},
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

  tosClick() {
    {
      tosStatus = !tosStatus;
      setState(() {});
    }
  }

  void _submit() async {
    closeKeyPad(context);
    if (formKey.currentState!.saveAndValidate()) {
      navigateTo(
        context,
        OtpScreen.routeName,
        arguments: OtpScreenData(
          email: emailCtrl.text,
          from: KeyString.businessSignupScreen,
          to: BusinessStepperWrapperScreen.routeName,
        ),
      );
    }
  }

  @override
  void dispose() {
    fullnameCtrl.dispose();
    companyNameCtrl.dispose();
    emailCtrl.dispose();
    pwdCtrl.dispose();
    super.dispose();
  }
}
