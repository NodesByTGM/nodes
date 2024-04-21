import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/business_account_model.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/profile/components/profile_cards.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';

class BusinessVerificationForm extends StatefulWidget {
  const BusinessVerificationForm({super.key});

  @override
  State<BusinessVerificationForm> createState() =>
      _BusinessVerificationFormState();
}

class _BusinessVerificationFormState extends State<BusinessVerificationForm> {
  late AuthController authCtrl;
  late UserModel user;
  late BusinessAccountModel businessAccount;
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController businessNameCtrl = TextEditingController();
  final TextEditingController yoeCtrl = TextEditingController();
  final TextEditingController locationCtrl = TextEditingController();
  final TextEditingController linkedinCtrl = TextEditingController();
  final formValues = {};
  File? profilePicture;
  XFile? cacThumbnailImageFile;
  bool isLoadingThumbnail = false;
  DateTime? yoe;

  @override
  void initState() {
    authCtrl = locator.get<AuthController>();
    user = authCtrl.currentUser;
    businessAccount = user.business as BusinessAccountModel;
    super.initState();
    loadProfile();
  }

  loadProfile() {
    businessNameCtrl.text = businessAccount.name ?? "";
    locationCtrl.text = businessAccount.location ?? "";
    yoeCtrl.text = isObjectEmpty(businessAccount.yoe)
        ? ''
        : shortDate(businessAccount.yoe as DateTime);
    yoe = businessAccount.yoe;
    linkedinCtrl.text = businessAccount.linkedIn ?? "";
    "";
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
    businessAccount = authCtrl.currentUser.business as BusinessAccountModel;
    return FormBuilder(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: labelText(
                          "Hi,${user.name?.split(" ").first}! To get started please verify your business."),
                    ),
                    xSpace(width: 10),
                    // Close Icon
                  ],
                ),
                ySpace(height: 10),
                subtext("To proceed please verify your business"),
                ySpace(height: 40),
                Row(
                  children: [
                    if (!isObjectEmpty(profilePicture)) ...[
                      Container(
                        width: 100,
                        height: 100,
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
                    ],
                    if (isObjectEmpty(profilePicture)) ...[
                      cachedNetworkImage(
                        imgUrl: "${businessAccount.logo?.url}",
                        size: 100,
                      ),
                    ],
                    xSpace(width: 16),
                    authCtrl.isUploadingMedia
                        ? const Loader()
                        : GestureDetector(
                            onTap: uploadImage,
                            child: labelText(
                              "Upload your logo",
                              color: PRIMARY,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ],
                ),
                ySpace(height: 32),
                FormWithLabel(
                  label: "Name of Business*",
                  form: FormBuilderTextField(
                    name: "businessName",
                    decoration: FormUtils.formDecoration(
                      hintText: "What’s the name of your business?",
                    ),
                    keyboardType: TextInputType.text,
                    style: FORM_STYLE,
                    controller: businessNameCtrl,
                    onSaved: (value) =>
                        formValues['businessName'] = trimValue(value),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: Constants.emptyFieldError),
                    ]),
                    onChanged: (val) {},
                  ),
                ),
                FormUtils.formSpacer(),
                FormWithLabel(
                  label: "Location",
                  form: FormBuilderTextField(
                    name: "location",
                    decoration: FormUtils.formDecoration(
                      hintText: "Enter your city",
                    ),
                    keyboardType: TextInputType.text,
                    style: FORM_STYLE,
                    controller: locationCtrl,
                    onChanged: (val) {},
                  ),
                ),
                FormUtils.formSpacer(),
                FormWithLabel(
                  label: "Year of establishment *",
                  form: FormBuilderTextField(
                    name: "yoe",
                    decoration: FormUtils.formDecoration(
                      hintText: "What year was your business established?",
                      suffixIcon: const Icon(Icons.date_range_outlined),
                    ),
                    readOnly: true,
                    style: FORM_STYLE,
                    controller: yoeCtrl,
                    onSaved: (value) => formValues['yoe'] = trimValue(value),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: Constants.emptyFieldError),
                    ]),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        lastDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        initialDate: DateTime.now(),
                      );
                      if (pickedDate == null) return;
                      yoeCtrl.text = shortDate(pickedDate);
                      yoe = pickedDate;
                      setState(() {});
                    },
                  ),
                ),
                FormUtils.formSpacer(),
                FormWithLabel(
                  label: "LinkedIn profile link",
                  form: FormBuilderTextField(
                    name: "linkedin",
                    decoration: FormUtils.formDecoration(
                      hintText: "Your linkedin profile link goes here",
                    ),
                    keyboardType: TextInputType.text,
                    style: FORM_STYLE,
                    controller: linkedinCtrl,
                    onChanged: (val) {},
                  ),
                ),
                FormUtils.formSpacer(),
                FormWithLabel(
                  label: "Upload CAC Document *",
                  form: GestureDetector(
                    onTap: cacImagePicker,
                    child: Stack(
                      children: [
                        if (isObjectEmpty(cacThumbnailImageFile)) ...[
                          CustomDottedBorder(
                            child: Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: Center(
                                child: subtext(
                                  "Click to browse your files\nRecommended image size: 280 x 160px",
                                  fontSize: 14,
                                  color: GRAY,
                                  fontWeight: FontWeight.w400,
                                  textAlign: TextAlign.center,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                        if (!isObjectEmpty(cacThumbnailImageFile)) ...[
                          Container(
                            height: 130,
                            width: screenWidth(context),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(cacThumbnailImageFile!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                        // Denoting Users can re-upload a new image...
                        if (!isObjectEmpty(cacThumbnailImageFile)) ...[
                          Positioned(
                            top: 40,
                            left: screenWidth(context) * .4,
                            child: const Icon(
                              Icons.add_circle,
                              color: BORDER,
                              size: 50,
                            ),
                          ),
                        ],

                        /// Loading Dialog on Empty Box
                        if (isLoadingThumbnail) ...[
                          Positioned(
                            top: 90,
                            left: screenWidth(context) * .42,
                            child: const CircularProgressIndicator.adaptive(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                ySpace(height: 100),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: WHITE,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlineBtn(
                        onPressed: () {
                          navigateBack(context);
                          // navigateBack(context); // as initstate is called twice
                        },
                        borderColor: BLACK,
                        child: btnTxt("Continue Later"),
                      ),
                    ),
                    xSpace(width: 16),
                    Expanded(
                      child: SubmitBtn(
                        onPressed: verifyBusiness,
                        title: btnTxt(
                          "Verify Business",
                          WHITE,
                        ),
                        loading: authCtrl.loading || authCtrl.isUploadingMedia,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void uploadImage() async {
    File? _ = await selectImageFromGallery();
    if (_ != null) {
      profilePicture = _;
      setState(() {});
    }
    String imageByteString =
        await convertFileToString("${profilePicture?.path}");
    // print("George, here's the imageByte: $imageByteString");

// Remember to delete the old image with the ID before uploading a new one...
    if (!isObjectEmpty(businessAccount.logo?.id)) {
      await authCtrl.deleteMedia("${businessAccount.logo?.id}");
    }
    MediaUploadModel? imageUrl = await authCtrl.mediaUpload(imageByteString);
    if (!isObjectEmpty(imageUrl)) {
      updateUserBusinessProfile(
        businessAccount.copyWith(logo: imageUrl),
      );
    }
  }

  void updateUserBusinessProfile(BusinessAccountModel business) async {
    await authCtrl.updateBusinessProfile(context, business.toJson());
  }

  @override
  void dispose() {
    businessNameCtrl.dispose();
    yoeCtrl.dispose();
    locationCtrl.dispose();
    linkedinCtrl.dispose();
    super.dispose();
  }

  void cacImagePicker() async {
    final ImagePicker imagePicker = locator.get<ImagePicker>();
    awaitingImageLoad(true);
    final XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    awaitingImageLoad(true);
    if (!isObjectEmpty(selectedImage)) {
      cacThumbnailImageFile = selectedImage;
    }
  }

  void awaitingImageLoad(bool bool) {
    setState(() {
      isLoadingThumbnail = !isLoadingThumbnail;
    });
  }

  void verifyBusiness() async {
    if (formKey.currentState!.saveAndValidate()) {
      if (isObjectEmpty(businessAccount.logo?.id)) {
        showText(message: "Please upload your Logo");
        return;
      }
      if (isObjectEmpty(cacThumbnailImageFile)) {
        showText(message: "Please upload your CAC Document");
        return;
      }
      String imageByteString =
          await convertFileToString("${cacThumbnailImageFile?.path}");
      MediaUploadModel? cacImageUrl =
          await authCtrl.mediaUpload(imageByteString);
      if (!isObjectEmpty(cacImageUrl)) { 
        // update profile with the data
        // Won't be needing this, since the verify endpoint should be returning the updated business data...
        // But will be leaving it because of the linkedIn,
        // updateUserBusinessProfile(
        //   businessAccount.copyWith(
        //     cac: cacImageUrl,
        //     linkedIn: linkedinCtrl.text,
        //   ),
        // );
        // Call the verification  API here
        bool done = await authCtrl.verifyBusiness({
          "name": businessNameCtrl.text,
          "logo": businessAccount.logo?.toJson(),
          "cac": cacImageUrl?.toJson(),
          "linkedIn": linkedinCtrl.text,
          "yoe": "$yoe",
        });
        if (done && mounted) {
          navigateBack(context);
          // navigateBack(context); // as initstate is called twice
        }
      }
    }
  }
}
