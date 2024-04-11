import 'package:multiple_search_selection/multiple_search_selection.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/individual_talent_onboarding_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class TStepTwoOfFive extends StatefulWidget {
  const TStepTwoOfFive({Key? key}) : super(key: key);

  @override
  State<TStepTwoOfFive> createState() => _TStepTwoOfFiveState();
}

// Pass data, email etc...
class _TStepTwoOfFiveState extends State<TStepTwoOfFive> {
  MultipleSearchController controller = MultipleSearchController();
  late AuthController _authCtrl;
  List<String> selectedSkills = [];
  List<String>? initialPickedItems = [];

  @override
  void initState() {
    _authCtrl = locator.get<AuthController>();
    initialPickedItems = _authCtrl.individualTalentData.skills;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _authCtrl = context.watch<AuthController>();
    return Column(
      children: [
        labelText(
          "What do you do?",
          fontSize: 20,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w500,
        ),
        ySpace(height: 40),
        MultipleSearchSelection<String>(
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
    // if (isObjectEmpty(selectedSkills)) {
    //   showText(message: "Please  select at least one skill");
    //   return;
    // }
    _authCtrl.setIndividualTalentData(_authCtrl.individualTalentData.copyWith(
      skills: selectedSkills,
    ));
    _authCtrl.setTStepper(3);
  }
}
