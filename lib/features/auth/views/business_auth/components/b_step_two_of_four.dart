import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class BStepTwoOfFour extends StatefulWidget {
  const BStepTwoOfFour({Key? key}) : super(key: key);

  @override
  State<BStepTwoOfFour> createState() => _BStepTwoOfFourState();
}

// Pass data, email etc...
class _BStepTwoOfFourState extends State<BStepTwoOfFour> {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController industryCtrl = TextEditingController();
  final TextEditingController sizeCtrl = TextEditingController();
  final TextEditingController typeCtrl = TextEditingController();
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
            "Company details",
            fontSize: 24,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
          ),
          ySpace(height: 40),
          SocialsFormWithLabel(
            label: "Company industry",
            form: FormBuilderTextField(
              name: "industry",
              decoration: FormUtils.formDecoration(
                hintText: "Example: Health",
                isTransparentBorder: true,
                verticalPadding: 10,
              ),
              keyboardType: TextInputType.text,
              style: FORM_STYLE,
              cursorColor: BLACK,
              controller: industryCtrl,
              onSaved: (value) => formValues['industry'] = trimValue(value),
              onChanged: (val) {},
            ),
          ),
          FormUtils.formSpacer(),
          SocialsFormWithLabel(
            label: "Company size",
            form: FormBuilderTextField(
              name: "size",
              decoration: FormUtils.formDecoration(
                hintText: "Example: 0-1 employees, 2-10 employees etc",
                isTransparentBorder: true,
                verticalPadding: 10,
              ),
              keyboardType: TextInputType.text,
              style: FORM_STYLE,
              cursorColor: BLACK,
              controller: sizeCtrl,
              onSaved: (value) => formValues['size'] = trimValue(value),
              onChanged: (val) {},
            ),
          ),
          FormUtils.formSpacer(),
          SocialsFormWithLabel(
            label: "Company type",
            form: FormBuilderTextField(
              name: "type",
              decoration: FormUtils.formDecoration(
                hintText: "Example: Public company, self employed etc",
                isTransparentBorder: true,
                verticalPadding: 10,
              ),
              keyboardType: TextInputType.text,
              style: FORM_STYLE,
              cursorColor: BLACK,
              controller: typeCtrl,
              onSaved: (value) => formValues['type'] = trimValue(value),
              onChanged: (val) {},
            ),
          ),
          ySpace(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              backBoxFn(
              onTap: () {
                _authCtrl.setBStepper(1);
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

  @override
  void dispose() {
    industryCtrl.dispose();
    sizeCtrl.dispose();
    typeCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    closeKeyPad(context);
    // remember to check with url with regex
    _authCtrl.setBStepper(3);
  }
}
