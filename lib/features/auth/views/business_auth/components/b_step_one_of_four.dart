import 'dart:io';

import 'package:expandable_section/expandable_section.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class BStepOneOfFour extends StatefulWidget {
  const BStepOneOfFour({Key? key}) : super(key: key);

  @override
  State<BStepOneOfFour> createState() => _BStepOneOfFourState();
}

// Pass data, email etc...
class _BStepOneOfFourState extends State<BStepOneOfFour> {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController websiteCtrl = TextEditingController();
  final TextEditingController taglineCtrl = TextEditingController();
  final formValues = {};
  File? companyPicture;

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
          OutlineBtn(
            onPressed: () async {
              File? _ = await selectImageFromGallery();
              if (_ != null) {
                companyPicture = _;
                setState(() {});
              }
            },
            borderColor: BORDER,
            child: Wrap(
              spacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SvgPicture.asset(ImageUtils.gallery),
                btnTxt("Upload a company logo", BLACK, 16),
              ],
            ),
          ),
          if (!isObjectEmpty(companyPicture)) ...[
            ySpace(height: 10),
            ExpandableSection(
              expand: true,
              child: Container(
                width: screenWidth(context),
                height: screenHeight(context) * 0.25,
                decoration: BoxDecoration(
                  color: BORDER.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: isObjectEmpty(companyPicture)
                      ? Container()
                      : Image.file(
                          companyPicture as File,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          ],
          FormUtils.formSpacer(),
          SocialsFormWithLabel(
            label: "Company website",
            form: FormBuilderTextField(
              name: "website",
              decoration: FormUtils.formDecoration(
                hintText: "Enter the company website",
                isTransparentBorder: true,
                verticalPadding: 10,
              ),
              keyboardType: TextInputType.text,
              style: FORM_STYLE,
              cursorColor: BLACK,
              controller: websiteCtrl,
              onSaved: (value) => formValues['website'] = trimValue(value),
              onChanged: (val) {},
            ),
          ),
          FormUtils.formSpacer(),
          SocialsFormWithLabel(
            label: "Company Tagline",
            form: FormBuilderTextField(
              name: "tagline",
              decoration: FormUtils.formDecoration(
                hintText: "Tell us what a little about the company.",
                isTransparentBorder: true,
                verticalPadding: 10,
              ),
              keyboardType: TextInputType.text,
              style: FORM_STYLE,
              cursorColor: BLACK,
              controller: taglineCtrl,
              onSaved: (value) => formValues['tagline'] = trimValue(value),
              onChanged: (val) {},
            ),
          ),
          FormUtils.formSpacer(),
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
    websiteCtrl.dispose();
    taglineCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    closeKeyPad(context);
    // remember to check with url with regex
  }
}
