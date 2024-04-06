import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/profile/components/expanable_profile_cards.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class EditIndividualProfileScreen extends StatefulWidget {
  const EditIndividualProfileScreen({super.key});
  static const String routeName = "/edit_individual_profile_screen";

  @override
  State<EditIndividualProfileScreen> createState() =>
      _EditIndividualProfileScreenState();
}

class _EditIndividualProfileScreenState
    extends State<EditIndividualProfileScreen> {
  late AuthController authCtrl;
  late UserModel user;
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController locationCtrl = TextEditingController();
  final TextEditingController headlineCtrl = TextEditingController();
  final TextEditingController bioCtrl = TextEditingController();
  final TextEditingController websiteCtrl = TextEditingController();
  final TextEditingController linkedinCtrl = TextEditingController();
  final TextEditingController instagramCtrl = TextEditingController();
  final TextEditingController xCtrl = TextEditingController();
  final formValues = {};
  bool isProfileInfo = true;
  bool isIntroduce = false;
  bool isOnlineProfile = false;
  bool isInteractions = false;
  bool enableSpaces = true;
  bool enableComments = true;

  @override
  void initState() {
    authCtrl = locator.get<AuthController>();
    user = authCtrl.currentUser;
    super.initState();
    loadProfile();
  }

  loadProfile() {
    firstNameCtrl.text = "${user.name?.split(' ').first}";
    lastNameCtrl.text = "${user.name?.split(' ').last}";
    usernameCtrl.text = "${user.username}";
    locationCtrl.text = "${user.location}";
    headlineCtrl.text = "${user.headline}";
    bioCtrl.text = "${user.bio}";

    websiteCtrl.text = "${user.website}";
    linkedinCtrl.text = "${user.linkedIn}";
    instagramCtrl.text = "${user.instagram}";
    xCtrl.text = "${user.twitter}";
    enableSpaces = user.spaces ?? false;
    enableComments = user.comments ?? false;
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
    return Container(
      decoration: const BoxDecoration(
          // gradient: profileLinearGradient,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ySpace(height: 40),
          GestureDetector(
            onTap: () {
              context.read<NavController>().popPageListStack();
            },
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Icon(
                  Icons.keyboard_arrow_left,
                  color: BORDER,
                ),
                subtext(
                  "Go Back",
                  fontSize: 12,
                ),
              ],
            ),
          ),
          ySpace(height: 20),
          Expanded(
            child: FormBuilder(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(3),
                  children: [
                    ExpanableProfileCard(
                      isExpanded: isProfileInfo,
                      title: "Personal Information",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              cachedNetworkImage(
                                imgUrl:
                                    "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
                                size: 100,
                              ),
                              xSpace(width: 16),
                              GestureDetector(
                                onTap: () {},
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
                          FormUtils.formSpacer(),
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
                            form: FormBuilderTextField(
                              name: "location",
                              decoration: FormUtils.formDecoration(
                                hintText: "Enter you city",
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
                            title: btnTxt("Save and Continue", WHITE),
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
                            title: btnTxt("Save and Continue", WHITE),
                            loading: authCtrl.loading,
                          ),
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
                                hintText:
                                    "https://www.linkedin.com/in/jane-doe/",
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
                                hintText:
                                    "https://www.Twitter.com/in/jane-doe/",
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
                            title: btnTxt("Save and Continue", WHITE),
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
                                  });
                                  if (enableSpaces) {
                                    _submit(3);
                                  }
                                },
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                enableSpaces = !enableSpaces;
                              });
                              if (enableSpaces) {
                                _submit(3);
                              }
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
                                  });
                                  if (enableComments) {
                                    _submit(4);
                                  }
                                },
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                enableComments = !enableComments;
                              });
                              if (enableComments) {
                                _submit(4);
                              }
                            },
                          ),
                          ySpace(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateAvata() async {
    //
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
        updateUserProfile(user = user.copyWith(
          name: "${firstNameCtrl.text} ${lastNameCtrl.text}",
          location: locationCtrl.text,
        ));
        return;
      case 1:
        // Update the introduction
        // Check if any madatory field is empty...
        if (isObjectEmpty(headlineCtrl.text) || isObjectEmpty(bioCtrl.text)) {
          showText(message: "Oops!! Please complete Introduction section");
          return;
        }
        updateUserProfile(user = user.copyWith(
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
        updateUserProfile(user = user.copyWith(
          website: websiteCtrl.text,
          linkedIn: linkedinCtrl.text,
          instagram: instagramCtrl.text,
          twitter: xCtrl.text,
        ));
        return;
      case 3:
        // Update the Toggle Spaces
        // Check if at least one field is provided...

        updateUserProfile(user = user.copyWith(
          spaces: enableSpaces,
          comments: enableComments,
        ));
        return;
      case 4:
        // Update the Toggle Comments
        // Check if at least one field is provided...

        updateUserProfile(user = user.copyWith(
          spaces: enableSpaces,
          comments: enableComments,
        ));
        return;
      default:
    }
    if (formKey.currentState!.saveAndValidate()) {}
    formKey.currentState!.reset();
  }

  void updateUserProfile(UserModel user) async {
    bool done = await authCtrl.updateProfile(user.toJson());
  }

  @override
  void dispose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    usernameCtrl.dispose();
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
