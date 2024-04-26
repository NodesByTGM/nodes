import 'dart:io';

import 'package:expandable_section/expandable_section.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/individual_talent_onboarding_model.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class TStepFourOfFive extends StatefulWidget {
  const TStepFourOfFive({Key? key}) : super(key: key);

  @override
  State<TStepFourOfFive> createState() => _TStepFourOfFiveState();
}

// Pass data, email etc...
class _TStepFourOfFiveState extends State<TStepFourOfFive> {
  File? profilePicture;
  late AuthController _authCtrl;

  @override
  void initState() {
    _authCtrl = locator.get<AuthController>();
    super.initState();
    preloadData();
  }

  preloadData() {
    // Check if the avatar has been selected
    IndividualTalentOnboardingModel data = _authCtrl.individualTalentData;
    if (isObjectEmpty(data.avatarFilePath)) return;
    profilePicture = File("${data.avatarFilePath}");
  }

  @override
  Widget build(BuildContext context) {
    _authCtrl = context.watch<AuthController>();
    return Column(
      children: [
        labelText(
          "Don't be shy, show the community\nwhat you look like.",
          fontSize: 20,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w500,
        ),
        ySpace(height: 40),
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
        ySpace(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            backBoxFn(
              onTap: () {
                _authCtrl.setTStepper(3);
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
    );
  }

  void _submit() async {
    closeKeyPad(context);
    // Send image binary file to server...and retrieve the url...actually do this last, before processing the onboarding, because as of then, user fit change their mind for choice of image
    if (isObjectEmpty(profilePicture)) {
      showText(message: "Please upload a picture to continue");
      return;
    }

    String imageByte = await convertFileToString("${profilePicture?.path}");

    MediaUploadModel? imageUrl = await _authCtrl.mediaUpload(imageByte);
    if (!isObjectEmpty(imageUrl)) {
      bool done = await _authCtrl.onboarding({
        "avatar": imageUrl?.toJson(),
        "step": 4, // Means STEP 4, has been completed,
      });
      if (done && mounted) {
        _authCtrl
            .setIndividualTalentData(_authCtrl.individualTalentData.copyWith(
          avatar: imageUrl, // Useful trick on the 5th step..
          avatarFilePath: profilePicture?.path,
        ));
      }
      _authCtrl.setTStepper(5);
    }
  }
}
