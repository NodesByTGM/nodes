import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class CreateNewSpace extends StatefulWidget {
  const CreateNewSpace({super.key});

  @override
  State<CreateNewSpace> createState() => _CreateNewSpaceState();
}

class _CreateNewSpaceState extends State<CreateNewSpace> {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();
  final TextEditingController titleCtrl = TextEditingController();
  final formValues = {};
  List<TextEditingController> dynamicTitleRulesCtrl = [
    TextEditingController(),
  ];
  List<TextEditingController> dynamicDescRulesCtrl = [
    TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilder(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormWithLabel(
                label: "Name of space",
                form: FormBuilderTextField(
                  name: "name_of_space",
                  decoration: FormUtils.formDecoration(
                    hintText: "Enter the name of the space here",
                  ),
                  keyboardType: TextInputType.text,
                  style: FORM_STYLE,
                  controller: nameCtrl,
                  onSaved: (value) =>
                      formValues['name_of_space'] = trimValue(value),
                  onChanged: (val) {},
                ),
              ),
              FormUtils.formSpacer(),
              FormWithLabel(
                label: "Category",
                form: FormBuilderDropdown<String>(
                  items: ['Automatic', 'Manual']
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: subtext(e, fontSize: 13),
                        ),
                      )
                      .toList(),
                  name: "category",
                  decoration: FormUtils.formDecoration(
                    verticalPadding: 12,
                    hintText: "Select a category",
                  ),
                  style: FORM_STYLE,
                  onSaved: (value) => formValues['category'] = value,
                ),
              ),
              FormUtils.formSpacer(),
              FormWithLabel(
                label: "Description",
                form: FormBuilderTextField(
                  name: "description",
                  decoration: FormUtils.formDecoration(
                    hintText: "What is this space about",
                  ),
                  keyboardType: TextInputType.text,
                  style: FORM_STYLE,
                  controller: descriptionCtrl,
                  maxLines: 3,
                  maxLength: 300,
                  onSaved: (value) =>
                      formValues['description'] = trimValue(value),
                  onChanged: (val) {},
                ),
              ),
              ySpace(height: 48),
              labelText(
                "Rules of the space",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              ySpace(height: 10),
              subtext(
                "Please, list out some rules for the space",
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              ySpace(height: 24),
              ListView.separated(
                itemCount: dynamicTitleRulesCtrl.length,
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
                            name: "title",
                            decoration: FormUtils.formDecoration(
                              hintText: "Title",
                              isTransparentBorder: true,
                              verticalPadding: 10,
                            ),
                            keyboardType: TextInputType.text,
                            style: FORM_STYLE,
                            cursorColor: BLACK,
                            controller: dynamicTitleRulesCtrl[i],
                            onSaved: (value) =>
                                formValues['title'] = trimValue(value),
                            onChanged: (val) {},
                          ),
                          lastForm: FormBuilderTextField(
                            name: "desc",
                            decoration: FormUtils.formDecoration(
                              hintText: "description",
                              isTransparentBorder: true,
                              verticalPadding: 10,
                            ),
                            keyboardType: TextInputType.text,
                            style: FORM_STYLE,
                            cursorColor: BLACK,
                            controller: dynamicDescRulesCtrl[i],
                            onSaved: (value) =>
                                formValues['desc'] = trimValue(value),
                            onChanged: (val) {},
                          ),
                        ),
                      ),
                      xSpace(width: 10),
                      if (i != 0) ...[
                        GestureDetector(
                          onTap: () => deleteRule(i),
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
              GestureDetector(
                onTap: () => addRule(),
                child: Row(
                  children: [
                    const Icon(
                      Icons.add_circle,
                      color: PRIMARY,
                      size: 30,
                    ),
                    xSpace(width: 10),
                    labelText(
                      "Add another rule",
                      color: PRIMARY,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              ySpace(height: 24),
              SubmitBtn(
                onPressed: _submit,
                title: btnTxt("Create space", WHITE),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void addRule() {
    for (var element in dynamicTitleRulesCtrl) {
      if (isObjectEmpty(element.text)) {
        showText(message: "Oops!!! Please fill the empty title.");
        return;
      }
      ;
    }
    for (var element in dynamicDescRulesCtrl) {
      if (isObjectEmpty(element.text)) {
        showText(message: "Oops!!! Please fill the empty description.");
        return;
      }
      
    }
    dynamicTitleRulesCtrl.add(TextEditingController());
    dynamicDescRulesCtrl.add(TextEditingController());
    setState(() {});
  }

  void deleteRule(int index) {
    dynamicTitleRulesCtrl.removeAt(index);
    dynamicDescRulesCtrl.removeAt(index);
    setState(() {});
  }

  void _submit() async {
    closeKeyPad(context);
    if (formKey.currentState!.saveAndValidate()) {}
    // for (var element in dynamicRulesCtrl) {
    //   print(element.text);
    // }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    descriptionCtrl.dispose();
    titleCtrl.dispose();
    for (var element in dynamicTitleRulesCtrl) {
      element.dispose();
    }
    for (var element in dynamicDescRulesCtrl) {
      element.dispose();
    }
    super.dispose();
  }
}
