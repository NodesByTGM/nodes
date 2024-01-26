import 'package:multiple_search_selection/multiple_search_selection.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class TStepOneOfFour extends StatefulWidget {
  const TStepOneOfFour({Key? key}) : super(key: key);

  @override
  State<TStepOneOfFour> createState() => _TStepOneOfFourState();
}

// Pass data, email etc...
class _TStepOneOfFourState extends State<TStepOneOfFour> {
  MultipleSearchController controller = MultipleSearchController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        labelText(
          "What do you do?",
          fontSize: 24,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w600,
        ),
        ySpace(height: 40),
        MultipleSearchSelection<String>(
          searchField: TextField(
            decoration: FormUtils.formDecoration(
              hintText: "Add up to 3 skills",
            ),
          ),
          onSearchChanged: (text) {
            // print('Text is $text');
          },
          items: const [
            'Production assitant',
            'Producer',
            'Production manager',
            'Project manager'
          ],
          fieldToCheck: (c) {
            return c; // String
          },
          itemBuilder: (skill, i) {
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
          onPickedChange: (items) {},
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
        ySpace(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: subtext(
            'Example: Modelling, Video editing...etc',
            fontSize: 14,
          ),
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

}
