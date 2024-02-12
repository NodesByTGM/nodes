import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  static const String routeName = "/forgotPasswordScreen";

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController emailCtrl = TextEditingController();
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
      body: SafeArea(
        child: Column(
          children: [
            ySpace(),
            labelText(
              "Reset password",
              fontSize: 24,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w600,
            ),
            ySpace(height: 8),
            subtext(
              "Forgot your password? Simply enter the email address associated with your Nodes account.",
              fontSize: 14,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w400,
            ),
            ySpace(height: 40),
            FormBuilder(
              key: formKey,
              child: Column(
                children: [
                  FormWithLabel(
                    label: "Email address *",
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
                        FormBuilderValidators.required(context,
                            errorText: Constants.emailError),
                        FormBuilderValidators.email(context,
                            errorText: Constants.emailInvalid),
                      ]),
                      onChanged: (val) {},
                    ),
                  ),
                ],
              ),
            ),
            ySpace(height: 24),
            SubmitBtn(
              onPressed: _submit,
              title: btnTxt("Reset password", WHITE),
            ),
          ],
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
    emailCtrl.dispose();
    super.dispose();
  }
}
