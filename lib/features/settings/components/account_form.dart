import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class AccountForm extends StatefulWidget {
  const AccountForm({super.key});

  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController fullnameCtrl = TextEditingController();
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController dobCtrl = TextEditingController();
  DateTime? dob;
  late bool isPublic;
  final formValues = {};
  late AuthController authCtrl;
  late UserModel user;

  @override
  void initState() {
    authCtrl = locator.get<AuthController>();
    user = authCtrl.currentUser;
    super.initState();
    loadProfile();
  }

  loadProfile() {
    fullnameCtrl.text = "${user.name}";
    usernameCtrl.text = "${user.username}";
    emailCtrl.text = "${user.email}";
    dobCtrl.text = shortDate(user.dob ?? DateTime.now());
    isPublic = user.visible;
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
    return FormBuilder(
      key: formKey,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ySpace(height: 40),
          FormWithLabel(
            label: "Full name *",
            form: FormBuilderTextField(
              name: "full_name",
              decoration: FormUtils.formDecoration(
                hintText: "Enter your full name",
              ),
              keyboardType: TextInputType.text,
              style: FORM_STYLE,
              controller: fullnameCtrl,
              onSaved: (value) => formValues['fullName'] = trimValue(value),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context,
                    errorText: Constants.emptyFieldError),
              ]),
              onChanged: (val) {},
            ),
          ),
          FormUtils.formSpacer(),
          FormWithLabel(
            label: "Username *",
            form: FormBuilderTextField(
              name: "username",
              decoration: FormUtils.formDecoration(
                hintText: "Enter your username",
                prefix: labelText("@ "),
              ),
              keyboardType: TextInputType.text,
              style: FORM_STYLE,
              controller: usernameCtrl,
              onSaved: (value) => formValues['username'] = trimValue(value),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context,
                    errorText: Constants.emptyFieldError),
              ]),
              onChanged: (val) {},
            ),
          ),
          FormUtils.formSpacer(),
          FormWithLabel(
            label: "Email address *",
            form: FormBuilderTextField(
              name: "email",
              decoration: FormUtils.formDecoration(
                hintText: "Enter your email address",
              ),
              keyboardType: TextInputType.emailAddress,
              style: FORM_STYLE,
              controller: emailCtrl,
              onSaved: (value) => formValues['email'] = trimValue(value),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context,
                    errorText: Constants.emailError),
                FormBuilderValidators.email(context,
                    errorText: Constants.emailInvalid),
              ]),
              onChanged: (val) {},
            ),
          ),
          FormUtils.formSpacer(),
          FormWithLabel(
            label: "Date of birth *",
            form: FormBuilderTextField(
              name: "dob",
              decoration: FormUtils.formDecoration(
                hintText: "DD/MM/YY",
                suffixIcon: const Icon(Icons.date_range_outlined),
              ),
              keyboardType: TextInputType.text,
              style: FORM_STYLE,
              controller: dobCtrl,
              readOnly: true,
              onTap: () async {
                DateTime _18yrs = DateTime(DateTime.now().year - 18);
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  lastDate: _18yrs,
                  firstDate: DateTime(1900),
                  initialDate: _18yrs,
                );
                if (pickedDate == null) return;
                // dobCtrl.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                // dobCtrl.text = DateFormat('dd/MM').format(pickedDate);
                dobCtrl.text = shortDate(pickedDate);
                dob = pickedDate;
              },
              onSaved: (value) => formValues['username'] = trimValue(value),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context,
                    errorText: Constants.emptyFieldError),
              ]),
              onChanged: (val) {},
            ),
          ),
          FormUtils.formSpacer(),
          FormWithLabel(
            label: "Profile visibility",
            form: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                profileVisibilityBtn(
                  onTap: () {
                    setState(() {
                      isPublic = !isPublic;
                    });
                  },
                  title: "Public",
                  isActive: isPublic,
                ),
                profileVisibilityBtn(
                  onTap: () {
                    setState(() {
                      isPublic = !isPublic;
                    });
                  },
                  title: "Private",
                  isActive: !isPublic,
                ),
              ],
            ),
          ),
          ySpace(height: 30),
          labelText(
            "Reset your password",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          ySpace(height: 24),
          labelText(
            "We believe in the power of every individual's creative spark. ",
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          ySpace(height: 24),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SubmitBtn(
                  onPressed: () {},
                  title: btnTxt("Reset your password", WHITE),
                  loading: false,
                ),
              ),
              const Spacer(),
            ],
          ),
          ySpace(height: 40),
          labelText(
            "Delete your account",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          ySpace(height: 24),
          labelText(
            "Once you delete your account, you can’t undo it. Please be certain.",
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          ySpace(height: 24),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SubmitBtn(
                  onPressed: deleteAccount,
                  title: btnTxt("Delete your account", WHITE),
                  color: RED,
                  loading: false,
                ),
              ),
              const Spacer(),
            ],
          ),
          ySpace(height: 40),
          customDivider(),
          SubmitBtn(
            onPressed: _submit,
            title: btnTxt("Save changes", WHITE),
            loading: authCtrl.loading,
          ),
          ySpace(height: 10),
        ],
      ),
    );
  }

  GestureDetector profileVisibilityBtn({
    required String title,
    required bool isActive,
    required GestureTapCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Checkbox(
            value: isActive,
            shape: const CircleBorder(),
            onChanged: (bool? value) {
              onTap();
            },
          ),
          labelText(
            title,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    fullnameCtrl.dispose();
    usernameCtrl.dispose();
    emailCtrl.dispose();
    dobCtrl.dispose();

    super.dispose();
  }

  void _submit() async {
    await authCtrl.updateProfile(context, getRequestData.toJson());
  }

  UserModel get getRequestData => user.copyWith(
        name: fullnameCtrl.text.trim(),
        username: usernameCtrl.text.trim(),
        email: emailCtrl.text.trim(),
        dob: dob,
        visible: isPublic,
      );

  void deleteAccount() async {
    final result = await showAlertDialog(
      context,
      body: subtext(
          "Are you sure you want to delete your account? This action is irrevocable.",
          fontSize: 13),
      title: "Delete Account",
      cancelTitle: "No, Cancel",
      okTitle: "Yes, Delete",
      okColor: RED,
      cancelColor: GRAY,
    );
    if (DialogAction.yes == result && mounted) {
      // make the api request, delete account, call the logout function, to send them to the auth screen...
    }
  }
}
