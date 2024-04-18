// ignore_for_file: use_build_context_synchronously

import 'package:flutter/services.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/standard_talent_job_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class CreateJobPost extends StatefulWidget {
  const CreateJobPost({
    super.key,
    this.job,
  });

  final BusinessJobModel? job;

  @override
  State<CreateJobPost> createState() => _CreateJobPostState();
}

class _CreateJobPostState extends State<CreateJobPost> {
  final formKey = GlobalKey<FormBuilderState>();
  late DashboardController dashCtrl;
  final TextEditingController jobTitleCtrl = TextEditingController();
  final TextEditingController hoursCtrl = TextEditingController();
  final TextEditingController rateCtrl = TextEditingController();
  final TextEditingController weeklyRateCtrl = TextEditingController();
  final TextEditingController locationCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  List<String> selectedSkills = [];
  List<String>? initialPickedItems = [];
  final formValues = {};
  late BusinessJobModel? job;

  @override
  void initState() {
    dashCtrl = locator.get<DashboardController>();
    job = widget.job;
    super.initState();
    loadEventData();
  }

  loadEventData() {
    if (!isObjectEmpty(job)) {
      jobTitleCtrl.text = "${job?.name}";
      // hoursCtrl.text = "${job?.payRate}";
      rateCtrl.text = "${job?.workRate}";
      weeklyRateCtrl.text = "${job?.workRate}";
      // locationCtrl.text = "${job?.location}";
      descCtrl.text = "${job?.description}";
      initialPickedItems = job?.skills ?? [];
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
                label: "Job Title",
                form: FormBuilderTextField(
                  name: "jobTitle",
                  decoration: FormUtils.formDecoration(
                    hintText: "Enter the title of the job here",
                  ),
                  keyboardType: TextInputType.text,
                  style: FORM_STYLE,
                  controller: jobTitleCtrl,
                  onSaved: (value) => formValues['jobTitle'] = trimValue(value),
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
              Row(
                children: [
                  Expanded(
                    child: FormWithLabel(
                      label: "Hours required per week",
                      form: FormBuilderTextField(
                        name: "hours",
                        decoration: FormUtils.formDecoration(
                          hintText: "E.g 20",
                        ),
                        keyboardType: TextInputType.number,
                        style: FORM_STYLE,
                        controller: hoursCtrl,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onSaved: (value) =>
                            formValues['hours'] = trimValue(value),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: Constants.emptyFieldError),
                        ]),
                        onChanged: (val) {
                          // _checActiveBtnColor();
                        },
                      ),
                    ),
                  ),
                  xSpace(width: 24),
                  Expanded(
                    child: FormWithLabel(
                      label: "Rate per hour",
                      form: FormBuilderTextField(
                        name: "rate",
                        decoration: FormUtils.formDecoration(
                          hintText: "E.g 20",
                        ),
                        keyboardType: TextInputType.number,
                        style: FORM_STYLE,
                        controller: rateCtrl,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onSaved: (value) =>
                            formValues['rate'] = trimValue(value),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: Constants.emptyFieldError),
                        ]),
                        onChanged: (val) {
                          // _checActiveBtnColor();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              FormUtils.formSpacer(),
              Row(
                children: [
                  Expanded(
                    child: FormWithLabel(
                      label: "Rate per week",
                      form: FormBuilderTextField(
                        name: "weeklyRate",
                        decoration: FormUtils.formDecoration(
                          hintText: "E.g 20",
                        ),
                        keyboardType: TextInputType.number,
                        style: FORM_STYLE,
                        controller: weeklyRateCtrl,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onSaved: (value) =>
                            formValues['weeklyRate'] = trimValue(value),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: Constants.emptyFieldError),
                        ]),
                        onChanged: (val) {},
                      ),
                    ),
                  ),
                  xSpace(width: 24),
                  Expanded(
                    child: FormWithLabel(
                      label: "Location",
                      form: FormBuilderTextField(
                        name: "location",
                        decoration: FormUtils.formDecoration(
                          hintText: "E.g Lagos, Nigeria",
                        ),
                        keyboardType: TextInputType.streetAddress,
                        style: FORM_STYLE,
                        controller: locationCtrl,
                        onSaved: (value) =>
                            formValues['lacation'] = trimValue(value),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: Constants.emptyFieldError),
                        ]),
                        onChanged: (val) {
                          // _checActiveBtnColor();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              FormUtils.formSpacer(),
              FormWithLabel(
                label: "Job Type",
                form: FormBuilderDropdown<String>(
                  items: Constants.jobType
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: subtext(e, fontSize: 13),
                        ),
                      )
                      .toList(),
                  name: "jobType",
                  decoration: FormUtils.formDecoration(
                    verticalPadding: 12,
                    hintText:
                        "Select a job type e.g contract, full time, freelance",
                  ),
                  style: FORM_STYLE,
                  // onSaved: (value) => formValues['jobType'] = value,
                  onSaved: (value) => formValues['jobType'] =
                      Constants.jobType.indexWhere((jT) => jT == value),
                ),
              ),
              FormUtils.formSpacer(),
              FormWithLabel(
                label: "Description",
                form: FormBuilderTextField(
                  name: "description",
                  decoration: FormUtils.formDecoration(
                    hintText: "Give more information about the job",
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
                label: "Skills required",
                form: MultipleSearchSelection<String>(
                  initialPickedItems: initialPickedItems,
                  searchField: TextField(
                    decoration: FormUtils.formDecoration(
                      hintText: "Add up to 3 skills",
                    ),
                  ),
                  onSearchChanged: (text) {
                    // print('Text is $text');
                  },
                  items: Constants.skillsList,
                  fieldToCheck: (c) {
                    return c; // String
                  },
                  itemBuilder: (skill, i) {
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 0.5, color: BORDER)),
                        color: WHITE,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 12,
                        ),
                        child: subtext(skill, color: const Color(0xFF757575)),
                      ),
                    );
                  },
                  pickedItemBuilder: (skill) {
                    return Container(
                      decoration: BoxDecoration(
                        color: BORDER.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: BORDER),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 8,
                        ),
                        child: Wrap(
                          spacing: 5,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            subtext(skill, color: BLACK.withOpacity(0.5)),
                            const Icon(
                              Icons.close,
                              color: GRAY,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  onTapShowedItem: () {},
                  onPickedChange: (items) {
                    setState(() {
                      selectedSkills = items;
                    });
                  },
                  onItemAdded: (item) {},
                  onItemRemoved: (item) {},
                  sortShowedItems: true,
                  sortPickedItems: true,
                  fuzzySearch: FuzzySearch.jaro,
                  itemsVisibility: ShowedItemsVisibility.onType,
                  pickedItemsBoxDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    border: Border.all(color: BORDER),
                  ),
                  placePickedItemContainerBelow: true,
                  showClearAllButton: false,
                  showSelectAllButton: false,
                  maximumShowItemsHeight: 200,
                ),
              ),
              ySpace(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: subtext(
                  'Example: Modelling, Video editing...etc',
                  fontSize: 14,
                ),
              ),
              FormUtils.formSpacer(),
              //
              SubmitBtn(
                onPressed: _submit,
                title: btnTxt(
                    isObjectEmpty(job) ? "Create job posting" : "Update Job",
                    WHITE),
                loading: dashCtrl.isCreatingJob || dashCtrl.isUpdatingJob,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _submit() async {
    closeKeyPad(context);
    if (formKey.currentState!.saveAndValidate()) {
      bool done = isObjectEmpty(job)
          ? await dashCtrl.createJob(context, {
              "name": jobTitleCtrl.text,
              "description": descCtrl.text,
              "experience": "1 - 3",
              "payRate": "\$${rateCtrl.text}/hr",
              "workRate": "\$${weeklyRateCtrl.text}/wk",
              "skills": selectedSkills,
              "jobType": formValues['jobType'],
            })
          : await dashCtrl.updateSingleJob(context, id: job?.id, payload: {
              "name": jobTitleCtrl.text,
              "description": descCtrl.text,
              "experience": "1 - 3",
              "payRate": "${rateCtrl.text}/hr",
              "workRate": "${weeklyRateCtrl.text}/wk",
              "skills": selectedSkills,
              "jobType": formValues['jobType'],
            });
      if (done && mounted) {
        navigateBack(context);
      }
    }
  }

  @override
  void dispose() {
    jobTitleCtrl.dispose();
    hoursCtrl.dispose();
    rateCtrl.dispose();
    weeklyRateCtrl.dispose();
    locationCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }
}
