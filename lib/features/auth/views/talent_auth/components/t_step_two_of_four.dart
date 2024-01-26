import 'package:flutter_textfield_autocomplete/flutter_textfield_autocomplete.dart';
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

  @override
  Widget build(BuildContext context) {
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
            Container(
              height: 50,
              width: 56,
              margin: const EdgeInsets.only(right: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  width: 1,
                  color: BORDER,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.keyboard_arrow_left,
                  size: 24,
                ),
              ),
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
  }

  @override
  void dispose() {
    locationCtrl.dispose();
    super.dispose();
  }
}
