// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:gallery_image_viewer/gallery_image_viewer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/community/models/create_post_model.dart';
import 'package:nodes/features/community/view_model/community_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class WritePostForm extends StatefulWidget {
  const WritePostForm({super.key});

  @override
  State<WritePostForm> createState() => _WritePostFormState();
}

class _WritePostFormState extends State<WritePostForm> {
  final formKey = GlobalKey<FormBuilderState>();
  late ComController comCtrl;
  final TextEditingController postCtrl = TextEditingController();
  final TextEditingController hashTagCtrl = TextEditingController();
  List<XFile> projectImageFileList = [];

  @override
  void initState() {
    comCtrl = locator.get<ComController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    comCtrl = context.watch<ComController>();
    return FormBuilder(
      key: formKey,
      child: ListView(
        shrinkWrap: true,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          FormBuilderTextField(
            name: "postMsg",
            decoration: FormUtils.formDecoration(
              hintText: "write your post...",
              isTransparentBorder: true,
            ),
            keyboardType: TextInputType.multiline,
            maxLength: 300,
            maxLines: 4,
            style: FORM_STYLE,
            controller: postCtrl,
            onChanged: (val) {},
          ),
          FormUtils.formSpacer(),
          FormBuilderTextField(
            name: "hashTags",
            decoration: FormUtils.formDecoration(
              hintText: "Add 1 or 2 #hashtags that represent your post",
              isTransparentBorder: true,
              verticalPadding: 12,
            ),
            keyboardType: TextInputType.text,
            style: FORM_STYLE.copyWith(
              color: PRIMARY,
              fontStyle: FontStyle.italic,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
            ],
            controller: hashTagCtrl,
            onChanged: (val) {},
          ),
          if (!isObjectEmpty(projectImageFileList)) ...[
            Container(
              width: screenWidth(context),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  crossAxisCount: projectImageFileList.length < 2 ? 1 : 2,
                  childAspectRatio: projectImageFileList.length < 3 ? 1 : 1.92,
                ),
                itemCount: projectImageFileList.length,
                itemBuilder: (context, index) {
                  File img = File(projectImageFileList[index].path);
                  return GestureDetector(
                    onTap: () => postImagePreviewer(
                      context,
                      images: projectImageFileList,
                      index: index,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        img,
                        // fit: BoxFit.fill,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
          customDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: multipleImagePicker,
                child: Icon(
                  MdiIcons.paperclip,
                ),
              ),
              SizedBox(
                width: 111,
                child: SubmitBtn(
                  onPressed: createAPost,
                  color: PRIMARY,
                  title: btnTxt(
                    "Post",
                    WHITE,
                  ),
                  loading: context.watch<AuthController>().isUploadingMedia ||
                      comCtrl.isCreatingPost,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // multipleImagePicker() async {
  //   final ImagePicker imagePicker = locator.get<ImagePicker>();
  //   final List<XFile> selectedImages =
  //       (await imagePicker.pickMultiImage(imageQuality: 10)).take(4).toList();
  //   if (selectedImages.isNotEmpty) {
  //     projectImageFileList.addAll(selectedImages);
  //   }
  //   setState(() {});
  // }

  multipleImagePicker() async {
    // Add a progress indicator...
    // awaitingImageLoad(false);
    final List<XFile>? selectedImages =
        await selectMultipleImageFromGallery(max: 4);
    if (!isObjectEmpty(selectedImages)) {
      projectImageFileList.addAll(selectedImages as List<XFile>);
    }
    setState(() {});
  }

  postImagePreviewer(
    context, {
    required List<XFile> images,
    required int index,
  }) {
    List<ImageProvider> _arr = [];
    for (var i in images) {
      if (!isObjectEmpty(i)) {
        _arr.add(FileImage(File(i.path)));
      }
    }
    MultiImageProvider multiImageProvider = MultiImageProvider(_arr);

    showImageViewerPager(
      context,
      multiImageProvider,
      closeButtonColor: RED,
      backgroundColor: BLACK,
      onPageChanged: (page) {
        // print("page changed to $page");
      },
      onViewerDismissed: (page) {
        // print("dismissed while on page $page");
      },
    );
  }

  void createAPost() async {
    // Check if user entered hastags, and if they'd used #
    if (!isObjectEmpty(hashTagCtrl.text) && !(hashTagCtrl.text).contains("#")) {
      showText(message: "Please use a #, to seperate your hastags");
      return;
    }
    // Upload Images to the server

    // The process, should be running on the Background... but if something went wrong, send the data to a draft or something...
    List<MediaUploadModel> imgList = await uploadProjectImages();
    comCtrl.createPost(
      context,
      CreatePostModel(
        body: postCtrl.text,
        attachments: imgList,
        hashtags: hashTagCtrl.text.split("#"),
      ),
    );
    navigateBack(context);
  }

  Future<List<MediaUploadModel>> uploadProjectImages() async {
    List<MediaUploadModel> imgList = [];
    if (isObjectEmpty(projectImageFileList)) {
      return imgList;
    } else {
      for (XFile file in projectImageFileList) {
        String imgBS = await convertFileToString(file.path);

        MediaUploadModel? url =
            await context.read<AuthController>().mediaUpload(imgBS);
        if (!isObjectEmpty(url)) {
          imgList.add(url!);
        }
      }
      return imgList;
    }
  }

  @override
  void dispose() {
    postCtrl.dispose();
    hashTagCtrl.dispose();
    super.dispose();
  }
}
