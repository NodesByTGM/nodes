import 'package:flutter_textfield_autocomplete/flutter_textfield_autocomplete.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class TStepTwoOfFour extends StatefulWidget {
  const TStepTwoOfFour({Key? key}) : super(key: key);

  @override
  State<TStepTwoOfFour> createState() => _TStepTwoOfFourState();
}

// Pass data, email etc...
class _TStepTwoOfFourState extends State<TStepTwoOfFour> {
  TextEditingController locationCtrl = TextEditingController();
  List<String> locationList = const [
    'USA',
    'Nigeria',
    'India',
    'Israel',
    'UK',
    'Brazil',
    'Ghana'
  ];
  GlobalKey<TextFieldAutoCompleteState<String>> autoCompleteKey = GlobalKey();

  late AuthController _authCtrl;

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
          "Where are you located?",
          fontSize: 24,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w600,
        ),
        ySpace(height: 40),
        TextFieldAutoComplete(
          decoration: FormUtils.formDecoration(
            hintText: "Location",
          ),
          clearOnSubmit: false,
          controller: locationCtrl,
          itemSubmitted: (String item) {
            locationCtrl.text = item;
          },
          suggestionsAmount: 1000,
          key: autoCompleteKey,
          suggestions: locationList,
          itemBuilder: (context, String item) {
            bool isSelected =
                item.toLowerCase() == locationCtrl.text.toLowerCase();
            return Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.5, color: BORDER)),
                color: WHITE,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    subtext(item, color: const Color(0xFF757575)),
                    if (isSelected)
                      const Icon(
                        Icons.check_circle_outline,
                        color: PRIMARY,
                        size: 15,
                      )
                  ],
                ),
              ),
            );
          },
          itemSorter: (String a, String b) {
            return a.compareTo(b);
          },
          itemFilter: (String item, query) {
            return item.toLowerCase().contains(query.toLowerCase());
          },
        ),
        ySpace(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            backBoxFn(
              onTap: () {
                _authCtrl.setTStepper(1);
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

  void _submit() async {
    closeKeyPad(context);
    _authCtrl.setTStepper(3);
  }

  @override
  void dispose() {
    locationCtrl.dispose();
    super.dispose();
  }
}
