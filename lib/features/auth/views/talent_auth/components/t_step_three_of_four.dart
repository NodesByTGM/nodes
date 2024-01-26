import 'dart:io';

import 'package:expandable_section/expandable_section.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class TStepThreeOfFour extends StatefulWidget {
  const TStepThreeOfFour({Key? key}) : super(key: key);

  @override
  State<TStepThreeOfFour> createState() => _TStepThreeOfFourState();
}

// Pass data, email etc...
class _TStepThreeOfFourState extends State<TStepThreeOfFour> {
  File? profilePicture;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        labelText(
          "Let’s see what you look like",
          fontSize: 24,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w600,
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
    );
  }

  void _submit() async {
    closeKeyPad(context);
  }
}
