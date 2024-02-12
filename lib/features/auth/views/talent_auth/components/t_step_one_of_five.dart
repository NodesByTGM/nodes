import 'package:expandable_section/expandable_section.dart';
import 'package:nodes/config/dependencies.dart';
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
          fontWeight: FontWeight.w600,
        ),
        ySpace(height: 40),
        todoCheckbox(
          value: connectWithCreatives,
          title: 'Connect with fellow creatives ',
          onTap: () {
            setState(() {
              connectWithCreatives = !connectWithCreatives;
            });
          },
          isActive: connectWithCreatives,
        ),
        ySpace(height: 8),
        todoCheckbox(
          value: findJobs,
          title: 'Find exciting job opportunities and gigs. ',
          onTap: () {
            setState(() {
              findJobs = !findJobs;
            });
          },
          isActive: findJobs,
        ),
        ySpace(height: 8),
        todoCheckbox(
          value: increaseVisibility,
          title: 'Increase visibility and showcase my work. ',
          onTap: () {
            setState(() {
              increaseVisibility = !increaseVisibility;
            });
          },
          isActive: increaseVisibility,
        ),
        ySpace(height: 8),
        todoCheckbox(
          value: exploreAndDiscover,
          title: 'Explore and discover inspiring projects. ',
          onTap: () {
            setState(() {
              exploreAndDiscover = !exploreAndDiscover;
            });
          },
          isActive: exploreAndDiscover,
        ),
        ySpace(height: 8),
        todoCheckbox(
          value: other,
          title: 'Something else ',
          onTap: () {
            setState(() {
              other = !other;
            });
          },
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
    _authCtrl.setTStepper(2);
  }
}
