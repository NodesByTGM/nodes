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

class AddProjectForm extends StatefulWidget {
  const AddProjectForm({super.key, required this.isBusiness,});

  final bool isBusiness;

  @override
  State<AddProjectForm> createState() => _AddProjectFormState();
}

class _AddProjectFormState extends State<AddProjectForm> {
  late AuthController authCtrl;
  late DashboardController dashCtrl;
  late UserModel user;
  final TextEditingController projectNameCtrl = TextEditingController();
  final TextEditingController projectDescCtrl = TextEditingController();
  final TextEditingController projectUrlCtrl = TextEditingController();
  final formValues = {};

  List<TextEditingController> dynamicNameCollaboratorsCtrl = [
    TextEditingController(),
  ];
  List<TextEditingController> dynamicRoleCollaboratorsCtrl = [
    TextEditingController(),
  ];

  List<XFile> projectImageFileList = [];
  XFile? logoImage;
  XFile? thumbnailImageFile;
  bool isLoadingThumbnail = false;
  bool isLoadingLogo = false;
late int maxProjectImages;
  bool isLoadingImage = false;
 
  @override
  void initState() {
    authCtrl = locator.get<AuthController>();
    dashCtrl = locator.get<DashboardController>();
    user = authCtrl.currentUser;
    maxProjectImages = widget.isBusiness ? 6 : 4;
    resetForm();
    super.initState();
  }

  resetForm() {
    projectNameCtrl.clear();
    projectDescCtrl.clear();
    projectUrlCtrl.clear();
    dynamicNameCollaboratorsCtrl = [TextEditingController()];
    dynamicRoleCollaboratorsCtrl = [TextEditingController()];
    projectImageFileList = <XFile>[];
    logoImage = null;
    thumbnailImageFile = null;
  }

  @override
  Widget build(BuildContext context) {
    dashCtrl = context.watch<DashboardController>();
    return Column(
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
            controller: projectNameCtrl,
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
              hintText: "Add a short bio to showcase your best self",
            ),
            keyboardType: TextInputType.multiline,
            style: FORM_STYLE,
            controller: projectDescCtrl,
            maxLength: 300,
            maxLines: 5,
            onSaved: (value) => formValues['description'] = trimValue(value),
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
              hintText: "A link to the project",
            ),
            keyboardType: TextInputType.text,
            style: FORM_STYLE,
            controller: projectUrlCtrl,
            onSaved: (value) => formValues['projectUrl'] = trimValue(value),
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
                      controller: dynamicNameCollaboratorsCtrl[i],
                      onSaved: (value) => formValues['name'] = trimValue(value),
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
                      onSaved: (value) => formValues['role'] = trimValue(value),
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
                    child: const CircularProgressIndicator.adaptive(),
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
                                  ? const CircularProgressIndicator.adaptive()
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
                            File img = File(projectImageFileList[i].path);
                            return Stack(
                              children: [
                                SizedBox(
                                  height: 180,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
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
                                        projectImageFileList.removeWhere(
                                            (element) =>
                                                element ==
                                                projectImageFileList[i]);
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
                          separatorBuilder: (c, i) => xSpace(width: 8),
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
                          child: const CircularProgressIndicator.adaptive(),
                        ),
                      ],
                    ],
                  ),
                ),
        ),
        ySpace(height: 40),
        SubmitBtn(
          onPressed: _submit,
          title: btnTxt("Save and Continue", WHITE),
          loading: authCtrl.isUploadingMedia || dashCtrl.isCreatingProject,
        ),
        ySpace(height: 20),
      ],
    );
  }

  void addCollaborator() {
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
      // final List<XFile> selectedImages = await imagePicker.pickMultiImage();
      final List<XFile> selectedImages =
          (await imagePicker.pickMultiImage()).take(maxProjectImages).toList();
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
          isLoadingLogo = !isLoadingLogo; // just putting it here
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
        "description": projectDescCtrl.text,
        "projectURL": projectUrlCtrl.text,
        "thumbnail": thumbnailUrl,
        "images": imgList,
        "collaborators": collateCollaboratorList(),
      });

      if (done && mounted) {
        // Clear the input fields...
        resetForm();
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
    projectDescCtrl.dispose();
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
