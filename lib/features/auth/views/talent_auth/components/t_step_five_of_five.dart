import 'dart:io';
import 'dart:typed_data';

import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/individual_talent_onboarding_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/auth/views/price_plan_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class TStepFiveOfFive extends StatefulWidget {
  const TStepFiveOfFive({Key? key}) : super(key: key);

  @override
  State<TStepFiveOfFive> createState() => _TStepFiveOfFiveState();
}

// Pass data, email etc...
class _TStepFiveOfFiveState extends State<TStepFiveOfFive> {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController linkedinCtrl = TextEditingController();
  final TextEditingController instagramCtrl = TextEditingController();
  final TextEditingController xCtrl = TextEditingController();

  final formValues = {};
  late AuthController _authCtrl;

  @override
  void initState() {
    _authCtrl = locator.get<AuthController>();
    preloadData();
    super.initState();
  }

  preloadData() {
    // Check if the avatar has been selected
    IndividualTalentOnboardingModel data = _authCtrl.individualTalentData;
    linkedinCtrl.text = data.linkedIn ?? '';
    instagramCtrl.text = data.instagram ?? '';
    xCtrl.text = data.twitter ?? '';
  }

  @override
  Widget build(BuildContext context) {
    _authCtrl = context.watch<AuthController>();
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          labelText(
            "Social media",
            fontSize: 20,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
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
                hintText: "Enter your X url",
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
                  _authCtrl.setTStepper(4);
                },
              ),
              Expanded(
                child: SubmitBtn(
                  onPressed: _submit,
                  title: btnTxt(Constants.continueText, WHITE),
                  loading: _authCtrl.isUploadingMedia,
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
    // if (1 < 2) {
    //   // Testing purpose
    //   print("George here is the currentSession: ${_authCtrl.currentUser}");
    //   navigateTo(context, PricePlanScreen.routeName);
    //   return;
    // }
    // if (formKey.currentState!.saveAndValidate()) {}
    // Atleast ONE must be provided...
    bool hasLinkedIn = isObjectEmpty(linkedinCtrl.text);
    bool hasTwitter = isObjectEmpty(xCtrl.text);
    bool hasInstagram = isObjectEmpty(instagramCtrl.text);
    //
    bool isValidLinkedIn = validateSocialMediaField(
      type: SocialMediaTypes.Linkedin,
      value: linkedinCtrl.text,
    );
    bool isValidTwitter = validateSocialMediaField(
      type: SocialMediaTypes.Twitter,
      value: xCtrl.text,
    );
    bool isValidInstagram = validateSocialMediaField(
      type: SocialMediaTypes.Instagram,
      value: instagramCtrl.text,
    );
    if (hasLinkedIn && hasInstagram && hasTwitter) {
      showText(message: "Please provide atleast ONE social media account");
      return;
    }
    if (!hasLinkedIn && !isValidLinkedIn) {
      // User entered linkedIn, but it's not a valid url
      showError(message: "Oops!!! This is not a valid LinkedIn URL");
      return;
    } else if (!hasInstagram && !isValidInstagram) {
      // User entered instagram, but it's not a valid url
      showError(message: "Oops!!! This is not a valid Instagram URL");
      return;
    } else if (!hasTwitter && !isValidTwitter) {
      // User entered twitter, but it's not a valid url
      showError(message: "Oops!!! This is not a valid X  URL");
      return;
    } else {
      _authCtrl.setIndividualTalentData(_authCtrl.individualTalentData.copyWith(
        linkedIn: hasLinkedIn ? "" : linkedinCtrl.text,
        instagram: hasInstagram ? "" : instagramCtrl.text,
        twitter: hasTwitter ? "" : xCtrl.text,
      ));
      // Onboard user first, before sending to the pricing screen....
      // 1. Upload the image to server, retrieve the url.

      // convert the avatar to binary
      Uint8List imageByte = await convertFileToBytes(
          "${_authCtrl.individualTalentData.avatarFilePath}");

      // String? imageUrl = await _authCtrl.mediaUpload(
      //   File("${_authCtrl.individualTalentData.avatarFilePath}"),
      // );

      String? imageUrl = await _authCtrl.mediaUpload(imageByte);
      if (isObjectEmpty(imageUrl)) {
        showError(
            message:
                "Oops!! an error occured while uploading you image, try again");
        return;
      }
      bool done = await _authCtrl.individualOnboarding({
        "skills": _authCtrl.individualTalentData.skills,
        "location": _authCtrl.individualTalentData.location,
        "avatar": imageUrl,
        "linkedIn": _authCtrl.individualTalentData.linkedIn,
        "instagram": _authCtrl.individualTalentData.instagram,
        "twitter": _authCtrl.individualTalentData.twitter,
        "otherPurpose": _authCtrl.individualTalentData.otherPurpose,
        "step": 5, // Meaning we have completed the onboarding process...
        "onboardingPurpose": _authCtrl.individualTalentData.onboardingPurpose,
        "onboardingPurposes": _authCtrl.individualTalentData.onboardingPurposes
      });
      if (done && mounted) {
        navigateAndClearPrev(context, PricePlanScreen.routeName);
      }

      // Comment out for now...
    }
  }

  @override
  void dispose() {
    linkedinCtrl.dispose();
    instagramCtrl.dispose();
    xCtrl.dispose();
    super.dispose();
  }
}
