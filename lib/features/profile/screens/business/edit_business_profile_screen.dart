import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/profile/components/expanable_profile_cards.dart';
import 'package:nodes/features/profile/components/profile_cards.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class EditBusinessProfileScreen extends StatefulWidget {
  const EditBusinessProfileScreen({super.key});
  static const String routeName = "/edit_business_profile_screen";

  @override
  State<EditBusinessProfileScreen> createState() =>
      _EditBusinessProfileScreenState();
}

class _EditBusinessProfileScreenState extends State<EditBusinessProfileScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController businessNameCtrl = TextEditingController();
  final TextEditingController locationCtrl = TextEditingController();
  final TextEditingController headlineCtrl = TextEditingController();
  final TextEditingController bioCtrl = TextEditingController();
  final TextEditingController websiteCtrl = TextEditingController();
  final TextEditingController linkedinCtrl = TextEditingController();
  final TextEditingController instagramCtrl = TextEditingController();
  final TextEditingController xCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  final TextEditingController projectUrlCtrl = TextEditingController();
  final formValues = {};
  bool isProfileInfo = true;
  bool isIntroduce = false;
  bool isAddProject = false;
  bool isOnlineProfile = false;
  bool isInteractions = false;
  bool enableSpaces = true;
  bool enableComments = true;
  List<TextEditingController> dynamicNameCollaboratorsCtrl = [
    TextEditingController(),
  ];
  List<TextEditingController> dynamicRoleCollaboratorsCtrl = [
    TextEditingController(),
  ];

  List<XFile> projectImageFileList = [];
  XFile? thumbnailImageFile;
  XFile? logoImage;
  bool isLoadingThumbnail = false;
  bool isLoadingLogo = false;
  bool isLoadingImage = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: PROFILEBG,
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
                                  "Replace Logo",
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
                              name: "doe",
                              decoration: FormUtils.formDecoration(
                                hintText: "",
                              ),
                              // keyboardType: TextInputType.text,
                              readOnly: true,
                              style: FORM_STYLE,

                              onSaved: (value) =>
                                  formValues['doe'] = trimValue(value),
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
                            onPressed: _submit,
                            title: btnTxt("Save and Continue", WHITE),
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
                            onPressed: _submit,
                            title: btnTxt("Save and Continue", WHITE),
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
                          FormWithLabel(
                            label: "Project name *",
                            form: FormBuilderTextField(
                              name: "projectName",
                              decoration: FormUtils.formDecoration(
                                hintText: "Ex: Actress, Actor, Director",
                              ),
                              keyboardType: TextInputType.text,
                              style: FORM_STYLE,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context,
                                    errorText: Constants.emptyFieldError),
                              ]),
                              onChanged: (val) {},
                            ),
                          ),
                          FormUtils.formSpacer(),
                          FormWithLabel(
                            label: "Description *",
                            form: FormBuilderTextField(
                              name: "desc",
                              decoration: FormUtils.formDecoration(
                                hintText:
                                    "Add a short bio to showcase your best self",
                              ),
                              keyboardType: TextInputType.multiline,
                              style: FORM_STYLE,
                              controller: descCtrl,
                              maxLength: 2000,
                              maxLines: 5,
                              onSaved: (value) =>
                                  formValues['description'] = trimValue(value),
                              validator: FormBuilderValidators.compose(
                                [
                                  FormBuilderValidators.required(context,
                                      errorText: Constants.emptyFieldError),
                                ],
                              ),
                              onChanged: (val) {},
                            ),
                          ),
                          FormUtils.formSpacer(),
                          FormWithLabel(
                            label: "Project URL *",
                            form: FormBuilderTextField(
                              name: "projectUrl",
                              decoration: FormUtils.formDecoration(
                                hintText: "Ex: Actress, Actor, Director",
                              ),
                              keyboardType: TextInputType.text,
                              style: FORM_STYLE,
                              controller: projectUrlCtrl,
                              onSaved: (value) =>
                                  formValues['projectUrl'] = trimValue(value),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context,
                                    errorText: Constants.emptyFieldError),
                              ]),
                              onChanged: (val) {},
                            ),
                          ),
                          FormUtils.formSpacer(),
                          labelText(
                            "Add collaborators",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          ySpace(height: 10),
                          subtext(
                            "You can add cast members...etc here",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          ySpace(height: 24),
                          ListView.separated(
                            itemCount: dynamicNameCollaboratorsCtrl.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (c, i) {
                              String index = "${i + 1}";
                              return Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 0.7,
                                        color: BORDER,
                                      ),
                                    ),
                                    child: Center(
                                      child: labelText(
                                        index,
                                        color: BORDER,
                                      ),
                                    ),
                                  ),
                                  xSpace(width: 10),
                                  Expanded(
                                    child: DoubleFormWithLabel(
                                      firstForm: FormBuilderTextField(
                                        name: "collaboratorName$i",
                                        decoration: FormUtils.formDecoration(
                                          hintText: "Name",
                                          isTransparentBorder: true,
                                          verticalPadding: 10,
                                        ),
                                        keyboardType: TextInputType.text,
                                        style: FORM_STYLE,
                                        cursorColor: BLACK,
                                        controller:
                                            dynamicNameCollaboratorsCtrl[i],
                                        onSaved: (value) => formValues['name'] =
                                            trimValue(value),
                                        onChanged: (val) {},
                                      ),
                                      lastForm: FormBuilderTextField(
                                        name: "collaboratorRole$i",
                                        decoration: FormUtils.formDecoration(
                                          hintText: "role",
                                          isTransparentBorder: true,
                                          verticalPadding: 10,
                                        ),
                                        keyboardType: TextInputType.text,
                                        style: FORM_STYLE,
                                        cursorColor: BLACK,
                                        controller:
                                            dynamicRoleCollaboratorsCtrl[i],
                                        onSaved: (value) => formValues['role'] =
                                            trimValue(value),
                                        onChanged: (val) {},
                                      ),
                                    ),
                                  ),
                                  xSpace(width: 10),
                                  if (i != 0) ...[
                                    GestureDetector(
                                      onTap: () => deleteCollaborator(i),
                                      child: const Icon(
                                        // Icons.remove_circle,
                                        Icons.delete_forever,
                                        color: RED,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ],
                              );
                            },
                            separatorBuilder: (c, i) => ySpace(height: 24),
                          ),
                          ySpace(height: 12),
                          GestureDetector(
                            onTap: () => addCollaborator(),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.add_circle,
                                  color: PRIMARY,
                                  size: 30,
                                ),
                                xSpace(width: 10),
                                labelText(
                                  "Add another collaborator",
                                  color: PRIMARY,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                          FormUtils.formSpacer(),
                          FormWithLabel(
                            label: "Project thumbnail",
                            form: GestureDetector(
                              onTap: () {
                                multipleImagePicker(
                                  isThumbnail: true,
                                );
                              },
                              child: Stack(
                                children: [
                                  if (isObjectEmpty(thumbnailImageFile)) ...[
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
                                  if (!isObjectEmpty(thumbnailImageFile)) ...[
                                    Container(
                                      height: 130,
                                      width: screenWidth(context),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(1),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          File(thumbnailImageFile!.path),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                  // Denoting Users can re-upload a new image...
                                  if (!isObjectEmpty(thumbnailImageFile)) ...[
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
                                      child: const CircularProgressIndicator
                                          .adaptive(),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          FormUtils.formSpacer(),
                          FormWithLabel(
                            label: "Project images",
                            form: !isObjectEmpty(projectImageFileList)
                                ? SizedBox(
                                    height: 150,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            multipleImagePicker();
                                          },
                                          child: Container(
                                            height: 180,
                                            width: 100,
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: CustomDottedBorder(
                                              child: Center(
                                                /// Loading Dialog on alreay selected boxes
                                                child: isLoadingImage
                                                    ? const CircularProgressIndicator
                                                        .adaptive()
                                                    : const Icon(
                                                        Icons.add,
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView.separated(
                                            itemCount:
                                                projectImageFileList.length,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (c, i) {
                                              File img = File(
                                                  projectImageFileList[i].path);
                                              return Stack(
                                                children: [
                                                  SizedBox(
                                                    height: 180,
                                                    width: 100,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.file(
                                                        img,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 5,
                                                    top: 10,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          projectImageFileList
                                                              .removeWhere(
                                                                  (element) =>
                                                                      element ==
                                                                      projectImageFileList[
                                                                          i]);
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.delete_outline,
                                                        color: RED,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                            separatorBuilder: (c, i) =>
                                                xSpace(width: 8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      multipleImagePicker();
                                    },
                                    child: Stack(
                                      children: [
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

                                        /// Loading Dialog on Empty Box
                                        if (isLoadingImage) ...[
                                          Positioned(
                                            top: 90,
                                            left: screenWidth(context) * .42,
                                            child:
                                                const CircularProgressIndicator
                                                    .adaptive(),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                          ),
                          ySpace(height: 40),
                          SubmitBtn(
                            onPressed: _submit,
                            title: btnTxt("Save an Continue", WHITE),
                          ),
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
                            onPressed: _submit,
                            title: btnTxt("Save and Continue", WHITE),
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
                                },
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                enableSpaces = !enableSpaces;
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
                                  });
                                },
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                enableComments = !enableComments;
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
            ),
          ),
        ],
      ),
    );
  }

  void addCollaborator() {
    for (var element in dynamicNameCollaboratorsCtrl) {
      if (isObjectEmpty(element.text)) {
        showText(message: "Oops!!! Please fill the empty name.");
        return;
      }
    }
    for (var element in dynamicRoleCollaboratorsCtrl) {
      if (isObjectEmpty(element.text)) {
        showText(message: "Oops!!! Please fill the empty role.");
        return;
      }
    }
    dynamicNameCollaboratorsCtrl.add(TextEditingController());
    dynamicRoleCollaboratorsCtrl.add(TextEditingController());
    setState(() {});
  }

  void deleteCollaborator(int index) {
    dynamicNameCollaboratorsCtrl.removeAt(index);
    dynamicRoleCollaboratorsCtrl.removeAt(index);
    setState(() {});
  }

  multipleImagePicker({
    bool isThumbnail = false,
    bool isLogo = false,
  }) async {
    final ImagePicker imagePicker = locator.get<ImagePicker>();
    if (isThumbnail) {
      awaitingImageLoad(true);
      final XFile? selectedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      awaitingImageLoad(true);
      if (!isObjectEmpty(selectedImage)) {
        thumbnailImageFile = selectedImage;
      }
    } else if (isLogo) {
      awaitingImageLoad(true);
      final XFile? selectedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      awaitingImageLoad(true);
      if (!isObjectEmpty(selectedImage)) {
        logoImage = selectedImage;
      }
    } else {
      awaitingImageLoad(false);
      final List<XFile> selectedImages = await imagePicker.pickMultiImage();
      awaitingImageLoad(false);
      if (selectedImages.isNotEmpty) {
        projectImageFileList.addAll(selectedImages);
      }
    }
    setState(() {});
  }

  awaitingImageLoad(bool isThumbnail) {
    switch (isThumbnail) {
      case true:
        setState(() {
          isLoadingThumbnail = !isLoadingThumbnail;
        });
        break;
      default:
        setState(() {
          isLoadingImage = !isLoadingImage;
        });
    }
  }

  void _submit() async {
    closeKeyPad(context);
    if (formKey.currentState!.saveAndValidate()) {}
    formKey.currentState!.reset();
  }

  @override
  void dispose() {
    businessNameCtrl.dispose();
    locationCtrl.dispose();
    headlineCtrl.dispose();
    bioCtrl.dispose();
    websiteCtrl.dispose();
    linkedinCtrl.dispose();
    instagramCtrl.dispose();
    xCtrl.dispose();
    descCtrl.dispose();
    projectUrlCtrl.dispose();
    for (var element in dynamicNameCollaboratorsCtrl) {
      element.dispose();
    }
    for (var element in dynamicRoleCollaboratorsCtrl) {
      element.dispose();
    }
    super.dispose();
  }
}
