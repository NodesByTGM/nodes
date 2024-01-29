import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class BStepThreeOfFour extends StatefulWidget {
  const BStepThreeOfFour({Key? key}) : super(key: key);

  @override
  State<BStepThreeOfFour> createState() => _BStepThreeOfFourState();
}

// Pass data, email etc...
class _BStepThreeOfFourState extends State<BStepThreeOfFour> {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController linkedinCtrl = TextEditingController();
  final TextEditingController instagramCtrl = TextEditingController();
  final TextEditingController xCtrl = TextEditingController();

  final formValues = {};
  late AuthController _authCtrl;

  @override
  void initState() {
    _authCtrl = locator.get<AuthController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _authCtrl = context.watch<AuthController>();
    return FormBuilder(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelText(
            "Social media",
            fontSize: 24,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
          ),
          ySpace(height: 40),
          SocialsFormWithLabel(
            label: "Linkedin",
            form: FormBuilderTextField(
              name: "linkedin",
              decoration: FormUtils.formDecoration(
                hintText: "Enter your linkedin url",
                isTransparentBorder: true,
                verticalPadding: 10,
              ),
              keyboardType: TextInputType.text,
              style: FORM_STYLE,
              cursorColor: BLACK,
              controller: linkedinCtrl,
              onSaved: (value) => formValues['linkedin'] = trimValue(value),
              onChanged: (val) {},
            ),
          ),
          FormUtils.formSpacer(),
          SocialsFormWithLabel(
            label: "Instagram",
            form: FormBuilderTextField(
              name: "instagram",
              decoration: FormUtils.formDecoration(
                hintText: "Enter your instagram url",
                isTransparentBorder: true,
                verticalPadding: 10,
              ),
              keyboardType: TextInputType.text,
              style: FORM_STYLE,
              cursorColor: BLACK,
              controller: instagramCtrl,
              onSaved: (value) => formValues['instagram'] = trimValue(value),
              onChanged: (val) {},
            ),
          ),
          FormUtils.formSpacer(),
          SocialsFormWithLabel(
            label: "X",
            form: FormBuilderTextField(
              name: "x",
              decoration: FormUtils.formDecoration(
                hintText: "EntEnter your X url",
                isTransparentBorder: true,
                verticalPadding: 10,
              ),
              keyboardType: TextInputType.text,
              style: FORM_STYLE,
              cursorColor: BLACK,
              controller: xCtrl,
              onSaved: (value) => formValues['x'] = trimValue(value),
              onChanged: (val) {},
            ),
          ),
          ySpace(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              backBoxFn(
                onTap: () {
                  _authCtrl.setBStepper(2);
                },
              ),
              Expanded(
                child: SubmitBtn(
                  onPressed: _submit,
                  title: btnTxt(Constants.continueText, WHITE),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submit() async {
    closeKeyPad(context);
    if (formKey.currentState!.saveAndValidate()) {}
    _authCtrl.setBStepper(4);
  }

  @override
  void dispose() {
    linkedinCtrl.dispose();
    instagramCtrl.dispose();
    xCtrl.dispose();
    super.dispose();
  }
}
