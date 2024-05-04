// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/profile/components/profile_cards.dart';
import 'package:nodes/features/saves/models/event_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({
    super.key,
    this.event,
  });

  final EventModel? event;

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final formKey = GlobalKey<FormBuilderState>();
  late DashboardController dashCtrl;
  late AuthController authCtrl;
  final TextEditingController eventCtrl = TextEditingController();
  final TextEditingController dateCtrl = TextEditingController();
  final TextEditingController timeCtrl = TextEditingController();

  final TextEditingController locationCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  String eventType = '';
  final formValues = {};
  late EventModel? event;
  File? thumbnailImageFile;
  bool isLoadingThumbnail = false;

  @override
  void initState() {
    dashCtrl = locator.get<DashboardController>();
    authCtrl = locator.get<AuthController>();
    event = widget.event;
    super.initState();
    loadEventData();
  }

  loadEventData() {
    if (!isObjectEmpty(event)) {
      eventCtrl.text = "${event?.name}";
      dateCtrl.text = shortDate(event?.dateTime ?? DateTime.now());
      timeCtrl.text = fromDatTimeToTimeOfDay(event?.dateTime ?? DateTime.now());
      locationCtrl.text = "${event?.location}";
      descCtrl.text = "${event?.description}";
      eventType = "${event?.paymentType}";
    }
  }

  @override
  Widget build(BuildContext context) {
    dashCtrl = context.watch<DashboardController>();
    authCtrl = context.watch<AuthController>();

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        FormBuilder(
          key: formKey,
          child: Column(
            children: [
              FormWithLabel(
                label: "Name of event",
                form: FormBuilderTextField(
                  name: "eventName",
                  decoration: FormUtils.formDecoration(
                    hintText: "Enter the name of the event here",
                  ),
                  keyboardType: TextInputType.text,
                  style: FORM_STYLE,
                  controller: eventCtrl,
                  onSaved: (value) =>
                      formValues['eventName'] = trimValue(value),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context,
                        errorText: Constants.emptyFieldError),
                  ]),
                  onChanged: (val) {},
                ),
              ),
              FormUtils.formSpacer(),
              Row(
                children: [
                  Expanded(
                    child: FormWithLabel(
                      label: "Date of event",
                      // Do a date picker...
                      form: FormBuilderTextField(
                        name: "eventDate",
                        decoration: FormUtils.formDecoration(
                          hintText: "Date of event",
                          suffixIcon: const Icon(Icons.date_range_rounded),
                        ),
                        readOnly: true,
                        style: FORM_STYLE,
                        controller: dateCtrl,
                        onSaved: (value) =>
                            formValues['eventDate'] = trimValue(value),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: Constants.emptyFieldError),
                        ]),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            lastDate: DateTime(DateTime.now().year + 5),
                            firstDate: DateTime.now(),
                            initialDate: DateTime.now(),
                          );
                          if (pickedDate == null) return;
                          dateCtrl.text = shortDate(pickedDate);
                        },
                      ),
                    ),
                  ),
                  xSpace(width: 24),
                  Expanded(
                    child: FormWithLabel(
                      label: "Time of event",
                      // Do a time picker...
                      //
                      form: FormBuilderTextField(
                        name: "EventTime",
                        decoration: FormUtils.formDecoration(
                          hintText: "Time of event",
                          suffixIcon: const Icon(Icons.alarm),
                        ),
                        readOnly: true,
                        style: FORM_STYLE,
                        controller: timeCtrl,
                        onSaved: (value) =>
                            formValues['eventTime'] = trimValue(value),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: Constants.emptyFieldError),
                        ]),
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime == null) return;
                          timeCtrl.text = timeOfDay(pickedTime);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              FormUtils.formSpacer(),
              FormWithLabel(
                label: "Location",
                form: FormBuilderTextField(
                  name: "location",
                  decoration: FormUtils.formDecoration(
                    hintText: "E.g Lagos, Nigeria",
                  ),
                  keyboardType: TextInputType.streetAddress,
                  style: FORM_STYLE,
                  controller: locationCtrl,
                  onSaved: (value) => formValues['location'] = trimValue(value),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context,
                        errorText: Constants.emptyFieldError),
                  ]),
                  onChanged: (val) {
                    // _checActiveBtnColor();
                  },
                ),
              ),
              FormUtils.formSpacer(),
              FormWithLabel(
                label: "Event Type",
                form: Row(
                  children: [
                    GestureDetector(
                      onTap: () => updateEventType('free'),
                      child: Wrap(
                        spacing: 5,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Radio.adaptive(
                            value: "free",
                            groupValue: eventType,
                            onChanged: (val) => updateEventType(val as String),
                          ),
                          subtext("Free"),
                        ],
                      ),
                    ),
                    xSpace(width: 24),
                    GestureDetector(
                      onTap: () => updateEventType('paid'),
                      child: Wrap(
                        spacing: 5,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Radio.adaptive(
                            value: 'paid',
                            groupValue: eventType,
                            onChanged: (val) => updateEventType(val as String),
                          ),
                          subtext("Paid"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              FormUtils.formSpacer(),
              FormWithLabel(
                label: "Description",
                form: FormBuilderTextField(
                  name: "description",
                  decoration: FormUtils.formDecoration(
                    hintText: "Give more information about the event",
                  ),
                  keyboardType: TextInputType.multiline,
                  style: FORM_STYLE,
                  controller: descCtrl,
                  maxLines: 7,
                  maxLength: 300,
                  onSaved: (value) =>
                      formValues['description'] = trimValue(value),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context,
                        errorText: Constants.emptyFieldError),
                  ]),
                  onChanged: (val) {
                    // _checActiveBtnColor();
                  },
                ),
              ),
              FormWithLabel(
                label: "Upload thumbnail",
                form: GestureDetector(
                  onTap: pickImage,
                  child: Stack(
                    children: [
                      if (!isObjectEmpty(event?.thumbnail?.url)) ...[
                        // When we are in edit event phase, and there's already a thumbnail URL
                        Stack(
                          children: [
                            Positioned(
                              child: Container(
                                height: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: cachedNetworkImage(
                                    imgUrl: "${event?.thumbnail?.url}",
                                    size: screenWidth(context),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (isObjectEmpty(thumbnailImageFile) &&
                          isObjectEmpty(event?.thumbnail?.id)) ...[
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
                          height: 170,
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
                      // Adding an replace icon Denoting Users can re-upload a new image, after either selecting a new thumbnail, or we on the edit event phase...

                      if (!isObjectEmpty(thumbnailImageFile) ||
                          !isObjectEmpty(event?.thumbnail?.id)) ...[
                        Positioned(
                          top: 60,
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
                          top: 100,
                          left: screenWidth(context) * .44,
                          child: const CircularProgressIndicator.adaptive(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              FormUtils.formSpacer(),
              //
              SubmitBtn(
                onPressed: _submit,
                title: btnTxt(
                    isObjectEmpty(event) ? "Create Event" : "Update Event",
                    WHITE),
                loading: authCtrl.isUploadingMedia ||
                    dashCtrl.isCreatingEvent ||
                    dashCtrl.isUpdatingEvent,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // pickImage() async {
  //   final ImagePicker imagePicker = locator.get<ImagePicker>();
  //   awaitingImageLoad();
  //   final XFile? selectedImage =
  //       await imagePicker.pickImage(source: ImageSource.gallery);
  //   awaitingImageLoad();
  //   if (!isObjectEmpty(selectedImage)) {
  //     thumbnailImageFile = selectedImage;
  //   }
  //   setState(() {});
  // }
  pickImage() async {
    awaitingImageLoad();
    File? _ = await selectImageFromGallery();
    awaitingImageLoad();
    if (_ != null) {
      setState(() {
        thumbnailImageFile = _;
      });
    }
  }

  awaitingImageLoad() {
    setState(() {
      isLoadingThumbnail = !isLoadingThumbnail;
    });
  }

  updateEventType(String val) {
    setState(() {
      eventType = val;
    });
  }

  void _submit() async {
    closeKeyPad(context);
    if (formKey.currentState!.saveAndValidate()) {
      if (isObjectEmpty(eventType)) {
        showText(message: "Please select the payment type");
        return;
      }
      if (isObjectEmpty(event?.thumbnail?.id) &&
          isObjectEmpty(thumbnailImageFile)) {
        // meaning even if na editing, we need to have had the thumbnail
        showText(message: "Please select event image");
        return;
      }
      // Get the image string...
      String? imageByteString;
      MediaUploadModel? thumbnailUrl;
      bool done = false;
      imageByteString =
          await convertFileToString("${thumbnailImageFile?.path}");
      // if (!isObjectEmpty(thumbnailImageFile)) {
      //   imageByteString = await convertFileToString("${thumbnailImageFile?.path}");
      //   thumbnailUrl = await authCtrl.mediaUpload(imageByteString);
      //   showError(
      //       message: "Oops!!! Error uploading event image. Please try again");
      //   return;
      // }
      if (isObjectEmpty(event)) {
        // Creating a new Event Entirely

        thumbnailUrl = await authCtrl.mediaUpload(imageByteString);
        if (isObjectEmpty(thumbnailUrl)) {
          showError(
              message: "Oops!!! Error uploading event image. Please try again");
          return;
        }
        done = await dashCtrl.createEvent(
          context,
          evetPayload(thumbnailUrl!),
        );
      } else {
        // Modifying an already existing Event
        if (!isObjectEmpty(event?.thumbnail?.id) &&
            !isObjectEmpty(thumbnailImageFile)) {
          // we are updating, and also user wants to change the event thumbnail...

          // upload new file...
          // imageByteString = await convertFileToString("${thumbnailImageFile?.path}");
          // thumbnailUrl = await authCtrl.mediaUpload(imageByteString);
          // if (isObjectEmpty(thumbnailUrl)) {
          //   showError(
          //       message:
          //           "Oops!!! Error uploading event image. Please try again");
          //   return;
          // }
          // Delete already existing image behind the scene, no need to hold up the thread...
          authCtrl.deleteMedia("${event?.thumbnail?.id}");
        }
        done = await dashCtrl.updateSingleEvent(
          context,
          id: event?.id,
          payload: evetPayload(
            thumbnailUrl ?? event?.thumbnail as MediaUploadModel,
          ),
        );
      }
      if (done && mounted) {
        navigateBack(context);
      }
    }
  }

  dynamic evetPayload(MediaUploadModel thumbnailUrl) {
    return {
      "name": eventCtrl.text,
      "description": descCtrl.text,
      "location": locationCtrl.text,
      "dateTime": dateCtrl.text,
      "paymentType": eventType,
      "thumbnail": thumbnailUrl,
    };
  }

  @override
  void dispose() {
    eventCtrl.dispose();
    dateCtrl.dispose();
    timeCtrl.dispose();
    locationCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }
}
