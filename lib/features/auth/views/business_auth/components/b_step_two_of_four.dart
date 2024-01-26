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

  @override
  Widget build(BuildContext context) {
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
              Container(
                height: 50,
                width: 56,
                margin: const EdgeInsets.only(right: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(
                    width: 1,
                    color: BORDER,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    size: 24,
                  ),
                ),
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
  }
}
