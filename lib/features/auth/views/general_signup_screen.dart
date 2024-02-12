import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nodes/features/auth/views/otp_screen.dart';
import 'package:nodes/features/auth/views/talent_auth/talent_stepper_wrapper.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';
import 'package:password_strength_indicator/password_strength_indicator.dart';

class GeneralSignupScreen extends StatefulWidget {
  const GeneralSignupScreen({Key? key}) : super(key: key);

  static const String routeName = "/generalSignupScreen";

  @override
  State<GeneralSignupScreen> createState() => _GeneralSignupScreenState();
}

class _GeneralSignupScreenState extends State<GeneralSignupScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController pwdCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController fullnameCtrl = TextEditingController();
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController confirmPwdCtrl = TextEditingController();
  final formValues = {};
  bool isPwd = false;
  bool isConfirmPwd = false;
  bool tosStatus = false;
  int? selectedDay;
  int? selectedMonth;
  int? selectedYear;
  String? passwordValue;

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
            "Welcome to Nodes!",
            fontSize: 24,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
          ),
          ySpace(height: 8),
          subtext(
            "Where creativtity knows no limits.",
            fontSize: 14,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w400,
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
                            onSaved: (value) =>
                                formValues['fullname'] = trimValue(value),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                context,
                                errorText: Constants.emptyFieldError,
                              ),
                            ]),
                            onChanged: (val) {},
                          ),
                        ),
                        FormUtils.formSpacer(),
                        FormWithLabel(
                          label: "Username*",
                          form: FormBuilderTextField(
                            name: "username",
                            decoration: FormUtils.formDecoration(
                              hintText: "Enter username",
                            ),
                            keyboardType: TextInputType.text,
                            style: FORM_STYLE,
                            controller: usernameCtrl,
                            onSaved: (value) =>
                                formValues['username'] = trimValue(value),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                context,
                                errorText: Constants.emptyFieldError,
                              ),
                            ]),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 5,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                subtext(
                                  "Date of birth*",
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    MdiIcons.informationSlabCircle,
                                    size: 20,
                                    color: BORDER,
                                  ),
                                )
                              ],
                            ),
                            ySpace(height: 8),
                            DropdownDatePicker(
                              locale: "en",
                              isFormValidator: true,
                              selectedDay: selectedDay,
                              selectedMonth: selectedMonth,
                              selectedYear: selectedYear,
                              onChangedDay: (v) {
                                selectedDay = int.parse(v!);
                              },
                              onChangedMonth: (v) {
                                selectedMonth = int.parse(v!);
                              },
                              onChangedYear: (v) {
                                selectedYear = int.parse(v!);
                              },
                              inputDecoration: FormUtils.formDecoration(),
                              dayFlex: 2,
                              // Limit the age to folks 18 and above from the current year
                              endYear: DateTime.now().year - 18,
                              hintDay: 'Day',
                              hintMonth: 'Month',
                              hintYear: 'Year',
                            ),
                          ],
                        ),
                        FormUtils.formSpacer(),
                        FormWithLabel(
                          label: "Password",
                          form: FormBuilderTextField(
                            name: "password",
                            decoration: FormUtils.formDecoration(
                              hintText: "+8  characters",
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
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                            ],
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
                                  errorText: Constants.passwordError,
                                ),
                              ],
                            ),
                            onChanged: (val) {
                              passwordValue = trimValue(val);
                              setState(() {});
                            },
                          ),
                        ),
                        ySpace(height: 5),
                        // Password bar...
                        PasswordStrengthIndicator(
                          password: passwordValue,
                          thickness: 4,
                          backgroundColor: BORDER,
                          radius: 2,
                          colors: const StrengthColors(
                            weak: RED,
                            medium: Colors.amber,
                            strong: Colors.green,
                          ),
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          callback: (double strength) {
                            // Receive the strength value of the password
                            debugPrint('Password Strength: $strength');
                          },
                          strengthBuilder: (String password) {
                            // Implement a custom strength builder to calculate the strength based on your criteria
                            // Return a value between 0.0 (too weak) and 1.0 (very strong)
                            // Example:
                            // return password.length / 10;
                            if (password.isEmpty) return 0.0;

                            // Check which types of characters are used and create an opinionated bonus.
                            // double charsetBonus;
                            // if (RegExp(r'^[a-z]*$').hasMatch(password)) {
                            //   charsetBonus = 0.1;
                            // } else if (RegExp(r'^[a-z0-9]*$')
                            //     .hasMatch(password)) {
                            //   charsetBonus = 0.2;
                            // } else if (RegExp(r'^[a-zA-Z]*$')
                            //     .hasMatch(password)) {
                            //   charsetBonus = 0.3;
                            // } else if (RegExp(r'^[a-z\-_!?]*$')
                            //     .hasMatch(password)) {
                            //   charsetBonus = 0.4;
                            // } else if (RegExp(r'^[a-zA-Z0-9]*$')
                            //     .hasMatch(password)) {
                            //   charsetBonus = 0.5;
                            // } else if (password.length > 8) {
                            //   charsetBonus = 0.8;
                            // } else {
                            //   charsetBonus = 1.0; // bug
                            // }
                            // return charsetBonus;

                            double charsetBonus = 0.0;
                            if (RegExp(r'^[a-z]*$').hasMatch(password)) {
                              // Small letter
                              charsetBonus = 0.1;
                            } else if (RegExp(r'^[a-z0-9]*$')
                                .hasMatch(password)) {
                              // small letters and numbers
                              charsetBonus = 0.2;
                            } else if (RegExp(r'^[a-zA-Z]*$')
                                .hasMatch(password)) {
                              // small letters and capslock
                              charsetBonus = 0.3;
                            } else if (RegExp(r'^[a-z\-_!?]*$')
                                .hasMatch(password)) {
                              // small letters and special characters
                              charsetBonus = 0.4;
                            } else if (RegExp(r'^[a-zA-Z0-9]*$')
                                .hasMatch(password)) {
                              // Caps Letter and Number
                              print(password.length);
                              charsetBonus = 0.5;
                              // } else if (password.length > 8) {
                            } else if (!RegExp(r'.{8,30}').hasMatch(password)) {
                              charsetBonus = 0.8;
                            } else {
                              // charsetBonus = 1.0; // bug
                              charsetBonus = charsetBonus;
                            }
                            return charsetBonus;

                            /**
                             * weak password- less than 8 characters
                                good password- 8 characters inclusive of a number or 8 numbers inclusive of a special character
                                Great password- 8 characters inclusive of a number and special character.
                             */
                          },
                          style: StrengthBarStyle.dashed,
                        ),

                        ySpace(height: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtext(
                              "Password strenth:",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: GRAY,
                            )
                          ],
                        ),
                        FormUtils.formSpacer(),
                        FormWithLabel(
                          label: "Confirm Password",
                          form: FormBuilderTextField(
                            name: "confirm_password",
                            decoration: FormUtils.formDecoration(
                              hintText: "Confirm password",
                              suffixIcon: InkWell(
                                onTap: () {
                                  isConfirmPwd = !isConfirmPwd;
                                  setState(() {});
                                },
                                child: Icon(
                                  isConfirmPwd
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: GRAY,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: FORM_STYLE,
                            controller: confirmPwdCtrl,
                            onSaved: (value) => formValues['confirm_password'] =
                                trimValue(value),
                            obscureText: !isConfirmPwd,
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                  context,
                                  errorText: Constants.confirmPassword,
                                ),
                              ],
                            ),
                            onChanged: (val) {
                              // _checActiveBtnColor();
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
                                        'I agree with the ',
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: tosText(
                                          "Terms of Service,",
                                          isUnderlined: true,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: tosText(
                                          "Privacy Policy",
                                          isUnderlined: true,
                                        ),
                                      ),
                                      tosText(
                                        "and default",
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: tosText(
                                          "Notification Settings.",
                                          isUnderlined: true,
                                          height: 1.6,
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
                          title: btnTxt("Sign In", WHITE),
                        ),
                      ],
                    ),
                  ),
                  ySpace(height: 24),
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
    navigateTo(
      context,
      OtpScreen.routeName,
      arguments: OtpScreenData(
        email: emailCtrl.text,
        from: KeyString.talentSignupScreen,
        to: TalentStepperWrapperScreen.routeName,
      ),
    );
    // if (formKey.currentState!.saveAndValidate()) {
    //   // LoginResponse? response =
    //   //     await context.read<AuthController>().signIn(_request);
    //   var response = "";

    //   if (!isObjectEmpty(response) && mounted) {
    //     safeNavigate(() {
    //       formKey.currentState!.reset();
    //       // if (response!.route == VerifyAccount.route) {
    //       //   navigateAndClearPrev(
    //       //     context,
    //       //     VerifyAccount.route,
    //       //     arguments: VerifyData(
    //       //       email: _request.email,
    //       //       nextRoute: NavbarView.routeName,
    //       //     ),
    //       //   );
    //       //   return;
    //       // }
    //       // navigateAndClearPrev(context, response.route);
    //       // context.read<AuthController>().resetVisibility();
    //     });
    //   }
    // }
  }

  @override
  void dispose() {
    fullnameCtrl.dispose();
    usernameCtrl.dispose();
    emailCtrl.dispose();
    pwdCtrl.dispose();
    confirmPwdCtrl.dispose();
    super.dispose();
  }

  tosClick() {
    {
      tosStatus = !tosStatus;
      setState(() {});
    }
  }
}
