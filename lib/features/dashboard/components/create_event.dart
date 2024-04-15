// ignore_for_file: use_build_context_synchronously

import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
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
  final TextEditingController eventCtrl = TextEditingController();
  final TextEditingController dateCtrl = TextEditingController();
  final TextEditingController timeCtrl = TextEditingController();

  final TextEditingController locationCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  String eventType = '';
  final formValues = {};
  late EventModel? event;

  @override
  void initState() {
    dashCtrl = locator.get<DashboardController>();
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

              FormUtils.formSpacer(),
              //
              SubmitBtn(
                onPressed: _submit,
                title: btnTxt(
                    isObjectEmpty(event) ? "Create Event" : "Update Event",
                    WHITE),
                loading: dashCtrl.isCreatingEvent || dashCtrl.isUpdatingEvent,
              ),
            ],
          ),
        ),
      ],
    );
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
      bool done = isObjectEmpty(event)
          ? await dashCtrl.createEvent(context, {
              "name": eventCtrl.text,
              "description": descCtrl.text,
              "location": locationCtrl.text,
              "dateTime": dateCtrl.text,
              "paymentType": eventType,
              "thumbnail": {
                "id": "xpkbzyctjeiwvnn8hmjh",
                "url":
                    "https://res.cloudinary.com/dwzhnrcdv/image/upload/v1712013809/xpkbzyctjeiwvnn8hmjh.png"
              }
            })
          : await dashCtrl.updateSingleEvent(context, id: event?.id, payload: {
              "name": eventCtrl.text,
              "description": descCtrl.text,
              "location": locationCtrl.text,
              "dateTime": dateCtrl.text,
              "paymentType": eventType,
              "thumbnail": {
                "id": "xpkbzyctjeiwvnn8hmjh",
                "url":
                    "https://res.cloudinary.com/dwzhnrcdv/image/upload/v1712013809/xpkbzyctjeiwvnn8hmjh.png"
              }
            });
      if (done && mounted) {
        navigateBack(context);
      }
    }
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
