import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/business_account_model.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/profile/components/expanable_profile_cards.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';
import 'package:nodes/utilities/utils/form_utils.dart';
import 'package:nodes/utilities/widgets/add_project_form.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';

class EditBusinessProfileScreen extends StatefulWidget {
  const EditBusinessProfileScreen({super.key});
  static const String routeName = "/edit_business_profile_screen";

  @override
  State<EditBusinessProfileScreen> createState() =>
      _EditBusinessProfileScreenState();
}

class _EditBusinessProfileScreenState extends State<EditBusinessProfileScreen> {
  late AuthController authCtrl;
  late UserModel user;
  late BusinessAccountModel businessAccount;
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController businessNameCtrl = TextEditingController();
  final TextEditingController yoeCtrl = TextEditingController();
  // final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController locationCtrl = TextEditingController();
  final TextEditingController headlineCtrl = TextEditingController();
  final TextEditingController bioCtrl = TextEditingController();
  final TextEditingController websiteCtrl = TextEditingController();
  final TextEditingController linkedinCtrl = TextEditingController();
  final TextEditingController instagramCtrl = TextEditingController();
  final TextEditingController xCtrl = TextEditingController();
  final formValues = {};
  File? profilePicture;
  bool isProfileInfo = true;
  bool isIntroduce = false;
  bool isAddProject = false;
  bool isOnlineProfile = false;
  DateTime? yoe;

  List<XFile> projectImageFileList = [];
  XFile? thumbnailImageFile;
  XFile? logoImage;
  bool isLoadingThumbnail = false;
  bool isLoadingLogo = false;
  bool isLoadingImage = false;

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
    // usernameCtrl.text = businessAccount.username ?? ";
    locationCtrl.text = businessAccount.location ?? "";
    headlineCtrl.text = businessAccount.headline ?? "";
    bioCtrl.text = businessAccount.bio ?? "";
    yoeCtrl.text = isObjectEmpty(businessAccount.yoe)
        ? ''
        : shortDate(businessAccount.yoe as DateTime);
    websiteCtrl.text = businessAccount.website ?? "";
    linkedinCtrl.text = businessAccount.linkedIn ?? "";
    instagramCtrl.text = businessAccount.instagram ?? "";
    xCtrl.text = businessAccount.twitter ?? "";
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
    businessAccount = authCtrl.currentUser.business as BusinessAccountModel;
    return Container(
      decoration: const BoxDecoration(
        color: PROFILEBG,
      ),
      child: FormBuilder(
        key: formKey,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                  right: 3,
                  top: 3,
                  left: 3,
                  bottom: 80,
                ),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  ySpace(height: 20),
                  ExpanableProfileCard(
                    isExpanded: isProfileInfo,
                    title: "Personal Information",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                      "Replace",
                                      color: PRIMARY,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ],
                        ),
                        ySpace(height: 32),
                        FormWithLabel(
                          label: "Name of Business",
                          form: FormBuilderTextField(
                            name: "businessName",
                            decoration: FormUtils.formDecoration(
                              hintText: "",
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
                          label: "Year of establishment",
                          form: FormBuilderTextField(
                            name: "yoe",
                            decoration: FormUtils.formDecoration(
                              hintText: "DD/MM/YY",
                              suffixIcon: const Icon(Icons.date_range_outlined),
                            ),
                            // keyboardType: TextInputType.text,
                            readOnly: true,
                            style: FORM_STYLE,
                            controller: yoeCtrl,
                            onSaved: (value) =>
                                formValues['yoe'] = trimValue(value),
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
                        // FormWithLabel(
                        //   label: "Username",
                        //   form: FormBuilderTextField(
                        //     name: "username",
                        //     decoration: FormUtils.formDecoration(
                        //       hintText: "",
                        //     ),
                        //     keyboardType: TextInputType.text,
                        //     style: FORM_STYLE,
                        //     controller: usernameCtrl,
                        //     readOnly: true,
                        //     onSaved: (value) =>
                        //         formValues['username'] = trimValue(value),
                        //     validator: FormBuilderValidators.compose([
                        //       FormBuilderValidators.required(context,
                        //           errorText: Constants.emptyFieldError),
                        //     ]),
                        //     onChanged: (val) {},
                        //   ),
                        // ),
                        // FormUtils.formSpacer(),
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
                            onSaved: (value) =>
                                formValues['location'] = trimValue(value),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context,
                                  errorText: Constants.emptyFieldError),
                            ]),
                            onChanged: (val) {},
                          ),
                        ),
                        ySpace(height: 40),
                        SubmitBtn(
                          onPressed: () => _submit(0),
                          title: btnTxt("Save", WHITE),
                          loading: authCtrl.loading,
                        ),
                        ySpace(height: 20),
                      ],
                    ),
                  ),
                  ySpace(height: 32),
                  ExpanableProfileCard(
                    isExpanded: isIntroduce,
                    title: "Introduce yourself",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ySpace(height: 16),
                        FormWithLabel(
                          label: "Headline",
                          form: FormBuilderTextField(
                            name: "headline",
                            decoration: FormUtils.formDecoration(
                              hintText: "Ex: Actress, Actor, Director",
                            ),
                            keyboardType: TextInputType.text,
                            style: FORM_STYLE,
                            controller: headlineCtrl,
                            maxLength: 50,
                            onSaved: (value) =>
                                formValues['headline'] = trimValue(value),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context,
                                  errorText: Constants.emptyFieldError),
                            ]),
                            onChanged: (val) {},
                          ),
                        ),
                        FormUtils.formSpacer(),
                        FormWithLabel(
                          label: "Your bio",
                          form: FormBuilderTextField(
                            name: "bio",
                            decoration: FormUtils.formDecoration(
                              hintText:
                                  "Add a short bio to showcase your best self",
                            ),
                            keyboardType: TextInputType.multiline,
                            style: FORM_STYLE,
                            controller: bioCtrl,
                            maxLength: 300,
                            maxLines: 5,
                            onSaved: (value) =>
                                formValues['bio'] = trimValue(value),
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(context,
                                    errorText: Constants.emptyFieldError),
                              ],
                            ),
                            onChanged: (val) {},
                          ),
                        ),
                        ySpace(height: 40),
                        SubmitBtn(
                          onPressed: () => _submit(1),
                          title: btnTxt("Save", WHITE),
                          loading: authCtrl.loading,
                        ),
                        ySpace(height: 20),
                      ],
                    ),
                  ),
                  ySpace(height: 32),
                  ExpanableProfileCard(
                    isExpanded: isAddProject,
                    title: "Add a project",
                    canOpen: isBusinessProfileComplete(businessAccount),
                    errorText: 'Please complete your Personal Info section',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ySpace(height: 16),
                        const AddProjectForm(isBusiness: true),
                        ySpace(height: 20),
                      ],
                    ),
                  ),
                  ySpace(height: 32),
                  ExpanableProfileCard(
                    isExpanded: isOnlineProfile,
                    title: "Online profiles",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ySpace(height: 16),
                        FormWithLabel(
                          label: "Personal website",
                          form: FormBuilderTextField(
                            name: "website",
                            decoration: FormUtils.formDecoration(
                              hintText: "http://",
                            ),
                            keyboardType: TextInputType.text,
                            style: FORM_STYLE,
                            controller: websiteCtrl,
                            onSaved: (value) =>
                                formValues['website'] = trimValue(value),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context,
                                  errorText: Constants.emptyFieldError),
                            ]),
                            onChanged: (val) {},
                          ),
                        ),
                        FormUtils.formSpacer(),
                        FormWithLabel(
                          label: "Linkedin",
                          form: FormBuilderTextField(
                            name: "linkedin",
                            decoration: FormUtils.formDecoration(
                              hintText: "https://www.linkedin.com/in/jane-doe/",
                            ),
                            keyboardType: TextInputType.text,
                            style: FORM_STYLE,
                            controller: linkedinCtrl,
                            onSaved: (value) =>
                                formValues['linkedin'] = trimValue(value),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context,
                                  errorText: Constants.emptyFieldError),
                            ]),
                            onChanged: (val) {},
                          ),
                        ),
                        FormUtils.formSpacer(),
                        FormWithLabel(
                          label: "Instagram",
                          form: FormBuilderTextField(
                            name: "instagram",
                            decoration: FormUtils.formDecoration(
                              hintText:
                                  "https://www.Instagram.com/in/jane-doe/",
                            ),
                            keyboardType: TextInputType.text,
                            style: FORM_STYLE,
                            controller: instagramCtrl,
                            onSaved: (value) =>
                                formValues['instagram'] = trimValue(value),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context,
                                  errorText: Constants.emptyFieldError),
                            ]),
                            onChanged: (val) {},
                          ),
                        ),
                        FormUtils.formSpacer(),
                        FormWithLabel(
                          label: "X",
                          form: FormBuilderTextField(
                            name: "x",
                            decoration: FormUtils.formDecoration(
                              hintText: "https://www.Twitter.com/in/jane-doe/",
                            ),
                            keyboardType: TextInputType.text,
                            style: FORM_STYLE,
                            controller: xCtrl,
                            onSaved: (value) =>
                                formValues['x'] = trimValue(value),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context,
                                  errorText: Constants.emptyFieldError),
                            ]),
                            onChanged: (val) {},
                          ),
                        ),
                        ySpace(height: 40),
                        SubmitBtn(
                          onPressed: () => _submit(2),
                          title: btnTxt("Save", WHITE),
                          loading: authCtrl.loading,
                        ),
                        ySpace(height: 20),
                      ],
                    ),
                  ),
                  ySpace(height: 32),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: screenWidth(context),
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                decoration: const BoxDecoration(
                  color: WHITE,
                  border: Border(
                    top: BorderSide(width: 0.7, color: BORDER),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    customNavigateBack(context);
                  },
                  child: labelText(
                    "Go Back",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
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

  void _submit(int index) {
    closeKeyPad(context);
    switch (index) {
      case 0:
        // Update the personal info
        // Check if any madatory field is empty...
        if (isObjectEmpty(businessNameCtrl.text) ||
            isObjectEmpty(yoe) ||
            isObjectEmpty(locationCtrl.text)) {
          showText(message: "Oops!! Please complete Personal Info section");
          return;
        }
        updateUserBusinessProfile(
          businessAccount.copyWith(
            name: businessNameCtrl.text,
            yoe: yoe,
            location: locationCtrl.text,
          ),
        );
        return;
      case 1:
        // Update the introduction
        // Check if any madatory field is empty...
        if (isObjectEmpty(headlineCtrl.text) || isObjectEmpty(bioCtrl.text)) {
          showText(message: "Oops!! Please complete Introduction section");
          return;
        }
        updateUserBusinessProfile(
          businessAccount.copyWith(
            headline: headlineCtrl.text,
            bio: bioCtrl.text,
          ),
        );
        return;
      case 2:
        // Update the online profiles
        // Check if at least one field is provided...
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
        }
        updateUserBusinessProfile(
          businessAccount.copyWith(
            website: websiteCtrl.text,
            linkedIn: linkedinCtrl.text,
            instagram: instagramCtrl.text,
            twitter: xCtrl.text,
          ),
        );
        return;

      default:
    }
    if (formKey.currentState!.saveAndValidate()) {}
    // formKey.currentState!.reset();
  }

  @override
  void dispose() {
    businessNameCtrl.dispose();
    yoeCtrl.dispose();
    // usernameCtrl.dispose();
    locationCtrl.dispose();
    headlineCtrl.dispose();
    bioCtrl.dispose();
    websiteCtrl.dispose();
    linkedinCtrl.dispose();
    instagramCtrl.dispose();
    xCtrl.dispose();
    super.dispose();
  }
}
