import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController eventCtrl = TextEditingController();
  final TextEditingController dateCtrl = TextEditingController();
  final TextEditingController timeCtrl = TextEditingController();

  final TextEditingController locationCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  String eventType = '';
  final formValues = {};

  @override
  Widget build(BuildContext context) {
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
                  onChanged: (val) {
                  },
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
                          timeCtrl.text = timOfDay(pickedTime);
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
                title: btnTxt("Create Event", WHITE),
                loading: false,
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
      //
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