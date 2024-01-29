import 'dart:io';

import 'package:expandable_section/expandable_section.dart';
import 'package:flutter_textfield_autocomplete/flutter_textfield_autocomplete.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class BStepFourOfFour extends StatefulWidget {
  const BStepFourOfFour({Key? key}) : super(key: key);

  @override
  State<BStepFourOfFour> createState() => _BStepFourOfFourState();
}

// Pass data, email etc...
class _BStepFourOfFourState extends State<BStepFourOfFour> {
  final formKey = GlobalKey<FormBuilderState>();
  File? profilePicture;
  TextEditingController locationCtrl = TextEditingController();
  TextEditingController professionalCtrl = TextEditingController();
  List<String> locationList = const [
    'USA',
    'Nigeria',
    'India',
    'Israel',
    'UK',
    'Brazil',
    'Ghana'
  ];
  GlobalKey<TextFieldAutoCompleteState<String>> autoCompleteKey = GlobalKey();

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
            "What do you do at The Grid Management",
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          ySpace(height: 40),
          FormBuilderTextField(
            name: "title",
            decoration: FormUtils.formDecoration(
              hintText: "Professional title",
            ),
            keyboardType: TextInputType.text,
            style: FORM_STYLE,
            controller: professionalCtrl,
            onSaved: (value) => formValues['title'] = trimValue(value),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                context,
                errorText: Constants.emptyFieldError,
              ),
            ]),
            onChanged: (val) {},
          ),
          ySpace(height: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              subtext(
                "Example: Hiring manager, Producer, Director:",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: GRAY,
              )
            ],
          ),
          FormUtils.formSpacer(),
          TextFieldAutoComplete(
            decoration: FormUtils.formDecoration(
              hintText: "Location",
            ),
            clearOnSubmit: false,
            controller: locationCtrl,
            itemSubmitted: (String item) {
              locationCtrl.text = item;
            },
            suggestionsAmount: 1000,
            key: autoCompleteKey,
            suggestions: locationList,
            itemBuilder: (context, String item) {
              bool isSelected =
                  item.toLowerCase() == locationCtrl.text.toLowerCase();
              return Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.5, color: BORDER)),
                  color: WHITE,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      subtext(item, color: const Color(0xFF757575)),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle_outline,
                          color: PRIMARY,
                          size: 15,
                        )
                    ],
                  ),
                ),
              );
            },
            itemSorter: (String a, String b) {
              return a.compareTo(b);
            },
            itemFilter: (String item, query) {
              return item.toLowerCase().contains(query.toLowerCase());
            },
          ),
          FormUtils.formSpacer(),
          OutlineBtn(
            onPressed: () async {
              File? _ = await selectImageFromGallery();
              if (_ != null) {
                profilePicture = _;
                setState(() {});
              }
            },
            borderColor: BORDER,
            child: Wrap(
              spacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SvgPicture.asset(ImageUtils.gallery),
                btnTxt("Upload a profile picture", BLACK, 16),
              ],
            ),
          ),
          if (!isObjectEmpty(profilePicture)) ...[
            ySpace(height: 10),
            ExpandableSection(
              expand: true,
              child: Container(
                width: screenWidth(context),
                height: screenHeight(context) * 0.5,
                decoration: BoxDecoration(
                  color: BORDER.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: isObjectEmpty(profilePicture)
                      ? Container()
                      : Image.file(
                          profilePicture as File,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          ],
          //
          ySpace(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              backBoxFn(
                onTap: () {
                  _authCtrl.setBStepper(3);
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
    _authCtrl.setBStepper(1); // Resets once data is submitted
  }

  @override
  void dispose() {
    locationCtrl.dispose();
    professionalCtrl.dispose();
    super.dispose();
  }
}
