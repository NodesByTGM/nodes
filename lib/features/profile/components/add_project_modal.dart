import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/model/project_model.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/profile/components/profile_cards.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class AddProject extends StatefulWidget {
  const AddProject({
    super.key,
    required this.isBusiness,
  });

  final bool isBusiness;

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  late AuthController authCtrl;
  late DashboardController dashCtrl;
  late UserModel user;
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController projectNameCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  final TextEditingController projectUrlCtrl = TextEditingController();
  final formValues = {};
  List<TextEditingController> dynamicNameCollaboratorsCtrl = [
    TextEditingController(),
  ];
  List<TextEditingController> dynamicRoleCollaboratorsCtrl = [
    TextEditingController(),
  ];
  double progressLevel = 0.5;

  List<XFile> projectImageFileList = [];
  File? thumbnailImageFile;
  bool isLoadingThumbnail = false;
  bool isLoadingImage = false;
  late int maxProjectImages;

  @override
  void initState() {
    authCtrl = locator.get<AuthController>();
    dashCtrl = locator.get<DashboardController>();
    user = authCtrl.currentUser;
    maxProjectImages = widget.isBusiness ? 6 : 4;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dashCtrl = context.watch<DashboardController>();
    return FormBuilder(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ySpace(height: 20),
            LinearProgressIndicator(
              value: progressLevel,
            ),
            ySpace(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                labelText(
                  "Add a project",
                ),
                GestureDetector(
                  onTap: () {
                    navigateBack(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.cancel,
                      color: PRIMARY,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
            ySpace(height: 12),
            Visibility(
              visible: progressLevel < 1,
              child: Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    FormWithLabel(
                      label: "Project name *",
                      form: FormBuilderTextField(
                        name: "pName",
                        decoration: FormUtils.formDecoration(
                          hintText: "Ex: Actress, Actor, Director",
                        ),
                        keyboardType: TextInputType.text,
                        style: FORM_STYLE,
                        controller: projectNameCtrl,
                        maxLength: 50,
                        onSaved: (value) =>
                            formValues['projectName'] = trimValue(value),
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
                      "Collaborators of the space",
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
                                  controller: dynamicNameCollaboratorsCtrl[i],
                                  onSaved: (value) =>
                                      formValues['title'] = trimValue(value),
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
                                  controller: dynamicRoleCollaboratorsCtrl[i],
                                  onSaved: (value) =>
                                      formValues['desc'] = trimValue(value),
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
                  ],
                ),
              ),
            ),
            //
            Visibility(
              visible: progressLevel == 1,
              child: Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
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
                                child:
                                    const CircularProgressIndicator.adaptive(),
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
                                      padding: const EdgeInsets.only(right: 5),
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
                                      itemCount: projectImageFileList.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (c, i) {
                                        File img =
                                            File(projectImageFileList[i].path);
                                        return Stack(
                                          children: [
                                            SizedBox(
                                              height: 180,
                                              width: 100,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
                                                        .removeWhere((element) =>
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
                                          "Click to browse your files\nRecommended $maxProjectImages images, size: 280 x 160px",
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
                                      child: const CircularProgressIndicator
                                          .adaptive(),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            ySpace(height: 10),
            Row(
              children: [
                if (progressLevel == 1) ...[
                  Expanded(
                    flex: 2,
                    child: OutlineBtn(
                      onPressed: () {
                        setState(() {
                          if (progressLevel == 1) {
                            progressLevel -= 0.5;
                          }
                        });
                      },
                      leftIcon: const Icon(
                        Icons.keyboard_arrow_left,
                      ),
                      borderColor: BORDER,
                      height: 48,
                      child: btnTxt("Back", GRAY),
                    ),
                  ),
                  xSpace(width: 20),
                ],
                Expanded(
                  flex: 3,
                  child: SubmitBtn(
                    onPressed: _submit,
                    title: btnTxt(
                      progressLevel == 1 ? "Add project" : "Save and Continue",
                      WHITE,
                    ),
                    loading:
                        dashCtrl.isUploadingMedia || dashCtrl.isCreatingEvent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void addCollaborator() {
    formKey.currentState!.save();
    int maxColabs = widget.isBusiness ? 10 : 8;
    if (dynamicNameCollaboratorsCtrl.length == maxColabs) {
      showText(
        message: "Oops!!! You have reached the max project collaborators",
      );
      return;
    }
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

  // void _submit() async {
  //   closeKeyPad(context);
  //   if (formKey.currentState!.saveAndValidate()) {}
  //   if (progressLevel < 1) {
  //     setState(() {
  //       progressLevel += 0.5;
  //     });
  //   } else {
  //     // Make the API call...
  //     navigateBack(context);
  //   }
  // }

  // multipleImagePicker({
  //   bool isThumbnail = false,
  // }) async {
  //   final ImagePicker imagePicker = locator.get<ImagePicker>();

  //   if (isThumbnail) {
  //     awaitingImageLoad(true);
  //     final XFile? selectedImage =
  //         await imagePicker.pickImage(source: ImageSource.gallery);
  //     awaitingImageLoad(true);
  //     if (!isObjectEmpty(selectedImage)) {
  //       thumbnailImageFile = selectedImage;
  //     }
  //   } else {
  //     awaitingImageLoad(false);
  //     final List<XFile> selectedImages =
  //         (await imagePicker.pickMultiImage()).take(maxProjectImages).toList();
  //     awaitingImageLoad(false);
  //     if (selectedImages.isNotEmpty) {
  //       projectImageFileList.addAll(selectedImages);
  //     }
  //   }
  //   setState(() {});
  // }
  multipleImagePicker({
    bool isThumbnail = false,
  }) async {
    if (isThumbnail) {
      awaitingImageLoad(true);
      File? _ = await selectImageFromGallery();
      awaitingImageLoad(true);
      if (_ != null) {
        setState(() {
          thumbnailImageFile = _;
        });
      }
    } else {
      awaitingImageLoad(false);
      final List<XFile>? selectedImages =
          await selectMultipleImageFromGallery(max: maxProjectImages);
      awaitingImageLoad(false);
      if (!isObjectEmpty(selectedImages)) {
        projectImageFileList.addAll(selectedImages as List<XFile>);
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
    // Confirm all fields are provided...
    closeKeyPad(context);
    if (progressLevel < 1) {
      // Check if the form is complete...
      if (isObjectEmpty(projectNameCtrl.text) ||
          isObjectEmpty(descCtrl.text) ||
          isObjectEmpty(projectUrlCtrl.text)) {
        showText(message: "Please complete this section");
        return;
      }
      setState(() {
        progressLevel += 0.5;
      });
      return;
    }

    if (isObjectEmpty(thumbnailImageFile)) {
      showText(message: "Thumbnail can't be empty");
      return;
    }
    if (isObjectEmpty(projectImageFileList)) {
      showText(message: "Project Images can't be empty");
      return;
    }
    // Upload images
    // 1. thumbnail
    String imageByteString =
        await convertFileToString("${thumbnailImageFile?.path}");

    MediaUploadModel? thumbnailUrl =
        await authCtrl.mediaUpload(imageByteString);
    List<Map<String, dynamic>> imgList = await uploadProjectImages();
    // 2. Project images
    if (mounted) {
      bool done = await dashCtrl.createProject(context, {
        "name": projectNameCtrl.text,
        "description": descCtrl.text,
        "projectURL": projectUrlCtrl.text,
        "thumbnail": thumbnailUrl,
        "images": imgList,
        "collaborators": collateCollaboratorList(),
      });

      if (done && mounted) {
        // Clear the input fields...
        navigateBack(context);
      }
    }
  }

  Future<List<Map<String, dynamic>>> uploadProjectImages() async {
    List<Map<String, dynamic>> imgList = [];
    if (isObjectEmpty(projectImageFileList)) {
      // Alert user that it's empty
    } else {
      for (XFile file in projectImageFileList) {
        String imgBS = await convertFileToString(file.path);

        MediaUploadModel? url = await authCtrl.mediaUpload(imgBS);
        if (!isObjectEmpty(url)) {
          imgList.add(url!.toJson());
        }
      }
      return imgList;
    }
    return imgList;
  }

  List<Map<String, dynamic>> collateCollaboratorList() {
    List<Map<String, dynamic>> collaboratorsList = [];
    for (var i = 0; i < dynamicNameCollaboratorsCtrl.length; i++) {
      collaboratorsList.add(CollaboratorModel(
        name: dynamicNameCollaboratorsCtrl[i].text,
        // Just praying the user provide this lol 
        role: dynamicRoleCollaboratorsCtrl[i].text,
      ).toJson());
    }
    return collaboratorsList;
  }

  @override
  void dispose() {
    projectNameCtrl.dispose();
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
