import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_textfield_autocomplete/flutter_textfield_autocomplete.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/country_state_model.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/profile/components/expanable_profile_cards.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';
import 'package:nodes/utilities/utils/form_utils.dart';
import 'package:nodes/utilities/widgets/add_project_form.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';

class EditTalentProfileScreen extends StatefulWidget {
  const EditTalentProfileScreen({super.key});
  static const String routeName = "/edit_talent_profile_screen";

  @override
  State<EditTalentProfileScreen> createState() =>
      _EditTalentProfileScreenState();
}

class _EditTalentProfileScreenState extends State<EditTalentProfileScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  late AuthController authCtrl;
  late DashboardController dashCtrl;
  late UserModel user;
  List<String>? locationList = const [];
  GlobalKey<TextFieldAutoCompleteState<String>> autoCompleteKey = GlobalKey();
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController locationCtrl = TextEditingController();
  final TextEditingController heightCtrl = TextEditingController();
  final TextEditingController ageCtrl = TextEditingController();
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
  bool isInteractions = false;
  bool enableSpaces = true;
  bool enableComments = true;

  @override
  void initState() {
    authCtrl = locator.get<AuthController>();
    dashCtrl = locator.get<DashboardController>();
    user = authCtrl.currentUser;
    super.initState();
    loadProfile();
    loadStates();
  }

  loadProfile() {
    firstNameCtrl.text = "${user.name?.split(' ').first}";
    lastNameCtrl.text = "${user.name?.split(' ').last}";
    usernameCtrl.text = "${user.username}";
    locationCtrl.text = "${user.location}";
    heightCtrl.text = "${user.height}";
    ageCtrl.text = "${user.age}";
    headlineCtrl.text = "${user.headline}";
    bioCtrl.text = "${user.bio}";

    websiteCtrl.text = "${user.website}";
    linkedinCtrl.text = "${user.linkedIn}";
    instagramCtrl.text = "${user.instagram}";
    xCtrl.text = "${user.twitter}";

    enableSpaces = user.spaces ?? false;
    enableComments = user.comments ?? false;
  }

  loadStates() {
    for (CountryStateModel element in authCtrl.countryStatesList) {
      locationList = [
        ...(locationList as List<String>),
        ...(element.states as List<String>)
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    // authCtrl = context.watch<AuthController>();
    // user = authCtrl.currentUser;
    dashCtrl = context.watch<DashboardController>();
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
                  bottom: 50,
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
                                imgUrl: "${user.avatar?.url}",
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
                          label: "First name",
                          form: FormBuilderTextField(
                            name: "fName",
                            decoration: FormUtils.formDecoration(
                              hintText: "",
                            ),
                            keyboardType: TextInputType.text,
                            style: FORM_STYLE,
                            controller: firstNameCtrl,
                            onSaved: (value) =>
                                formValues['firstName'] = trimValue(value),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context,
                                  errorText: Constants.emptyFieldError),
                            ]),
                            onChanged: (val) {},
                          ),
                        ),
                        FormUtils.formSpacer(),
                        FormWithLabel(
                          label: "Last name",
                          form: FormBuilderTextField(
                            name: "lName",
                            decoration: FormUtils.formDecoration(
                              hintText: "",
                            ),
                            keyboardType: TextInputType.text,
                            style: FORM_STYLE,
                            controller: lastNameCtrl,
                            onSaved: (value) =>
                                formValues['lastName'] = trimValue(value),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context,
                                  errorText: Constants.emptyFieldError),
                            ]),
                            onChanged: (val) {},
                          ),
                        ),
                        FormWithLabel(
                          label: "Username",
                          form: FormBuilderTextField(
                            name: "username",
                            decoration: FormUtils.formDecoration(
                              hintText: "",
                              prefix: labelText(
                                '@ ',
                                color: GRAY,
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: FORM_STYLE,
                            controller: usernameCtrl,
                            readOnly: true,
                            onSaved: (value) =>
                                formValues['username'] = trimValue(value),
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
                          form: TextFieldAutoComplete(
                            decoration: FormUtils.formDecoration(
                              hintText: "Location - search by state",
                            ),
                            clearOnSubmit: false,
                            controller: locationCtrl,
                            itemSubmitted: (String? item) {
                              locationCtrl.text = item ?? '';
                            },
                            suggestionsAmount: 1000,
                            key: autoCompleteKey,
                            suggestions: locationList ?? [''],
                            itemBuilder: (context, String item) {
                              bool isSelected = item.toLowerCase() ==
                                  locationCtrl.text.toLowerCase();
                              return Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.5, color: BORDER)),
                                  color: WHITE,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 12,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: subtext(
                                        item,
                                        color: const Color(0xFF757575),
                                      )),
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
                              return item
                                  .toLowerCase()
                                  .contains(query.toLowerCase());
                            },
                          ),
                        ),
                        FormUtils.formSpacer(),
                        Row(
                          children: [
                            Expanded(
                              child: FormWithLabel(
                                label: "Height(cm)",
                                form: FormBuilderTextField(
                                  name: "height",
                                  decoration: FormUtils.formDecoration(
                                    hintText: "Enter your height",
                                  ),
                                  keyboardType: TextInputType.number,
                                  style: FORM_STYLE,
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.digitsOnly,
                                  // ],
                                  controller: heightCtrl,
                                  onSaved: (value) =>
                                      formValues['height'] = trimValue(value),
                                  onChanged: (val) {},
                                ),
                              ),
                            ),
                            xSpace(width: 15),
                            Expanded(
                              child: FormWithLabel(
                                label: "Age(years)",
                                form: FormBuilderTextField(
                                  name: "age",
                                  decoration: FormUtils.formDecoration(
                                    hintText: "Enter your age",
                                  ),
                                  keyboardType: TextInputType.number,
                                  style: FORM_STYLE,
                                  readOnly: true,
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.digitsOnly,
                                  // ],
                                  controller: ageCtrl,
                                  onSaved: (value) =>
                                      formValues['height'] = trimValue(value),
                                  onChanged: (val) {},
                                ),
                              ),
                            ),
                          ],
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ySpace(height: 16),
                        const AddProjectForm(),
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
                  ExpanableProfileCard(
                    isExpanded: isInteractions,
                    title: "Interactions",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ySpace(height: 16),
                        ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: labelText(
                              "Spaces",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: subtext(
                            "Enabling this will allow all your acitivity in spaces show up on your profile",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 1.5,
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Switch(
                              value: enableSpaces,
                              onChanged: (val) {
                                setState(() {
                                  enableSpaces = !enableSpaces;
                                  _submit(3);
                                });
                              },
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              enableSpaces = !enableSpaces;
                              _submit(3);
                            });
                          },
                        ),
                        FormUtils.formSpacer(),
                        ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: labelText(
                              "Comments",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: subtext(
                            "Enabling this will allow all your acitivity in spaces show up on your profile",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 1.5,
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Switch(
                              value: enableComments,
                              onChanged: (val) {
                                setState(() {
                                  enableComments = !enableComments;
                                  _submit(4);
                                });
                              },
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              enableComments = !enableComments;
                              _submit(4);
                            });
                          },
                        ),
                        ySpace(height: 16),
                      ],
                    ),
                  ),
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

  void _submit(int index) {
    closeKeyPad(context);
    switch (index) {
      case 0:
        // Update the personal info
        // Check if any madatory field is empty...
        if (isObjectEmpty(firstNameCtrl.text) ||
            isObjectEmpty(lastNameCtrl.text) ||
            isObjectEmpty(locationCtrl.text)) {
          showText(message: "Oops!! Please complete Personal Info section");
          return;
        }
        updateUserProfile(user.copyWith(
          name: "${firstNameCtrl.text} ${lastNameCtrl.text}",
          location: locationCtrl.text,
          height: heightCtrl.text,
        ));
        return;
      case 1:
        // Update the introduction
        // Check if any madatory field is empty...
        if (isObjectEmpty(headlineCtrl.text) || isObjectEmpty(bioCtrl.text)) {
          showText(message: "Oops!! Please complete Introduction section");
          return;
        }
        updateUserProfile(user.copyWith(
          headline: headlineCtrl.text,
          bio: bioCtrl.text,
        ));
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
        updateUserProfile(user.copyWith(
          website: websiteCtrl.text,
          linkedIn: linkedinCtrl.text,
          instagram: instagramCtrl.text,
          twitter: xCtrl.text,
        ));
        return;
      case 3:
        // Update the Toggle Spaces
        // Check if at least one field is provided...

        updateUserProfile(user.copyWith(
          spaces: enableSpaces,
          comments: enableComments,
        ));
        return;
      case 4:
        // Update the Toggle Comments
        // Check if at least one field is provided...

        updateUserProfile(user.copyWith(
          spaces: enableSpaces,
          comments: enableComments,
        ));
        return;
      default:
    }
    if (formKey.currentState!.saveAndValidate()) {}
    // formKey.currentState!.reset();
  }

  void updateUserProfile(UserModel user) async {
    await authCtrl.updateProfile(context, user.toJson());
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
    MediaUploadModel? imageUrl = await authCtrl.mediaUpload(imageByteString);
    if (!isObjectEmpty(imageUrl)) {
      updateUserProfile(user.copyWith(avatar: imageUrl));
    }
  }

  @override
  void dispose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    usernameCtrl.dispose();
    locationCtrl.dispose();
    heightCtrl.dispose();
    ageCtrl.dispose();
    headlineCtrl.dispose();
    bioCtrl.dispose();
    websiteCtrl.dispose();
    linkedinCtrl.dispose();
    instagramCtrl.dispose();
    xCtrl.dispose();
    super.dispose();
  }
}
