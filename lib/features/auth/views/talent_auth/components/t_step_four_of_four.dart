import 'dart:io';

import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class TStepFourOfFour extends StatefulWidget {
  const TStepFourOfFour({Key? key}) : super(key: key);

  @override
  State<TStepFourOfFour> createState() => _TStepFourOfFourState();
}

// Pass data, email etc...
class _TStepFourOfFourState extends State<TStepFourOfFour> {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController linkedinCtrl = TextEditingController();
  final TextEditingController instagramCtrl = TextEditingController();
  final TextEditingController xCtrl = TextEditingController();

  final formValues = {};
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
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

  void _submit() async {
    closeKeyPad(context);
    if (formKey.currentState!.saveAndValidate()) {}
  }

  @override
  void dispose() {
    linkedinCtrl.dispose();
    instagramCtrl.dispose();
    xCtrl.dispose();
    super.dispose();
  }
}
