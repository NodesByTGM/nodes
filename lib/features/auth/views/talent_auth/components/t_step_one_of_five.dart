import 'package:expandable_section/expandable_section.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/individual_talent_onboarding_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class TStepOneOfFive extends StatefulWidget {
  const TStepOneOfFive({Key? key}) : super(key: key);

  @override
  State<TStepOneOfFive> createState() => _TStepOneOfFiveState();
}

// Pass data, email etc...
class _TStepOneOfFiveState extends State<TStepOneOfFive> {
  final TextEditingController otherCtrl = TextEditingController();
  late AuthController _authCtrl;
  bool connectWithCreatives = false;
  bool findJobs = false;
  bool increaseVisibility = false;
  bool exploreAndDiscover = false;
  bool other = false;
  final formValues = {};

  @override
  void initState() {
    _authCtrl = locator.get<AuthController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _authCtrl = context.watch<AuthController>();
    return Column(
      children: [
        labelText(
          "What do you want to do on Nodes?",
          fontSize: 20,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w500,
        ),
        ySpace(height: 40),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: onboardingPurposeArray.length,
          itemBuilder: (c, i) {
            String title = onboardingPurposeArray[i].title;
            bool status = onboardingPurposeArray[i].status;
            return todoCheckbox(
              value: status,
              title: title,
              onTap: () {
                setState(() {
                  // de-selecting the 'something else' option
                  other = false;
                  // clearing the data in the 'something else' input field.
                  otherCtrl.clear();
                  onboardingPurposeArray[i].status =
                      !onboardingPurposeArray[i].status;
                });
              },
              isActive: connectWithCreatives,
            );
          },
          separatorBuilder: (c, i) => ySpace(height: 8),
        ),
        ySpace(height: 8),
        todoCheckbox(
          value: other,
          title: 'Something else ',
          onTap: somethingElseOptionFn,
          isActive: other,
          isOther: true,
        ),
        ySpace(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            backBoxFn(
              onTap: () {
                navigateBack(context);
              },
            ),
            Expanded(
              child: SubmitBtn(
                onPressed: _submit,
                title: btnTxt(Constants.continueText, WHITE),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<PurposeModel> onboardingPurposeArray = [
    PurposeModel(
      title: "Connect with fellow creatives",
      status: false,
    ),
    PurposeModel(
      title: "Find exciting job opportunities and gigs.",
      status: false,
    ),
    PurposeModel(
      title: 'Increase visibility and showcase my work. ',
      status: false,
    ),
    PurposeModel(
      title: 'Explore and discover inspiring projects. ',
      status: false,
    ),
  ];

  void somethingElseOptionFn() {
    setState(() {
      other = !other;
      for (var i = 0; i < onboardingPurposeArray.length; i++) {
        onboardingPurposeArray[i].status = false;
      }
    });
  }

  Column todoCheckbox({
    required bool value,
    required String title,
    required GestureCancelCallback onTap,
    required bool isActive,
    isOther = false,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16, right: 5),
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.6,
              color: BORDER,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: Checkbox(
              value: value,
              visualDensity: VisualDensity.compact,
              onChanged: (val) => onTap(),
              activeColor: PRIMARY,
            ),
            title: subtext(title),
            onTap: onTap,
          ),
        ),
        if (isOther) ...[
          ySpace(height: 8),
          ExpandableSection(
            expand: isOther && value,
            child: FormBuilderTextField(
              name: "tell_us",
              decoration: FormUtils.formDecoration(
                hintText: "Tell us more...",
              ),
              maxLines: 3,
              keyboardType: TextInputType.text,
              style: FORM_STYLE,
              controller: otherCtrl,
              onSaved: (value) => formValues['others'] = trimValue(value),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context,
                    errorText: Constants.emptyFieldError),
              ]),
              onChanged: (val) {},
            ),
          ),
        ],
      ],
    );
  }

  @override
  void dispose() {
    otherCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    closeKeyPad(context);
    // setting up the data....
    int index = onboardingPurposeArray.indexWhere((element) => element.status);
    if (index == -1 && !other) {
      // this means user didn't select anything.
      showText(message: "Please select at least  ONE purpose");
      return;
    }
    _authCtrl.setIndividualTalentData(_authCtrl.individualTalentData.copyWith(
      onboardingPurpose: index > -1 ? (index + 1) : 0,
      // for now, i'm getting the index of the first value that is true...until backend updates this value to an array of selectable items.
      // The index + 1, is so that i can match the array from the BE, i.e,
      /**
       * OnboaringPurpose {
            NotSelected = 0,
            Connection = 1,
            Jobs = 2,
            Showcase = 3,
            ExploreProjects = 4,
            Others = 5,
        }
       */
      onboardingPurposes: getOnboardingPurposes(),
      otherPurpose: !isObjectEmpty(otherCtrl.text) ? otherCtrl.text : null,
    ));
    _authCtrl.setTStepper(2);
  }

  List<String> getOnboardingPurposes() {
    List<String> arr = [];
    // if the other option was selected
    if (!isObjectEmpty(otherCtrl.text)) {
      arr.add(otherCtrl.text);
      return arr;
    }
    // else, run through the purposes.
    for (PurposeModel d in onboardingPurposeArray) {
      if (d.status) {
        arr.add(d.title);
      }
    }
    return arr;
  }
}

class PurposeModel {
  final String title;
  bool status;

  PurposeModel({required this.title, required this.status});
}
