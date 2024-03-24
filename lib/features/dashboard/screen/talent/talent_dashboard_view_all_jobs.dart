import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/dashboard/components/job_card.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class TalentJobCenterScreen extends StatefulWidget {
  const TalentJobCenterScreen({super.key});
  static const String routeName = "/job_center_screen";

  @override
  State<TalentJobCenterScreen> createState() => _TalentJobCenterScreenState();
}

class _TalentJobCenterScreenState extends State<TalentJobCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        ySpace(height: 40),
        GestureDetector(
          onTap: () {
            context.read<NavController>().popPageListStack();
          },
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(
                Icons.keyboard_arrow_left,
                color: BORDER,
              ),
              subtext(
                "Go Back",
                fontSize: 12,
              ),
            ],
          ),
        ),
        ySpace(height: 20),
        labelText(
          "Hi, Jane! Welcome to the Nodes Job center",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        ySpace(height: 20),
        StickyHeaderBuilder(
          builder: (context, stuckAmount) {
            return Container(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 20,
              ),
              // color: stuckAmount <= -0.54 ? WHITE : null,
              color: WHITE,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: FormBuilderTextField(
                      name: "email",
                      decoration: FormUtils.formDecoration(
                        hintText: "Search",
                        verticalPadding: 12,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      style: FORM_STYLE,
                      // controller: searchCtrl,

                      onChanged: (val) {},
                    ),
                  ),
                  // xSpace(width: 30),
                  const Spacer(),
                  Expanded(
                    // flex: 2,
                    child: Container(
                      margin: const EdgeInsets.only(right: 6),
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 10,
                        right: 5,
                      ),
                      decoration: BoxDecoration(
                        color: WHITE,
                        border: Border.all(width: 0.7, color: PRIMARY),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: PopupMenuButton<String>(
                        onSelected: (value) {},
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: 'skills',
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  subtext("Skills"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'rate',
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  subtext("Rate"),
                                ],
                              ),
                            ),
                          ];
                        },
                        offset: const Offset(0, 40),
                        color: WHITE,
                        elevation: 2,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 5,
                          children: [
                            const Icon(
                              Icons.sort,
                              color: PRIMARY,
                            ),
                            labelText(
                              "Filter",
                              fontSize: 12,
                              color: PRIMARY,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          content: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (c, i) {
              return const JobCard();
            },
            separatorBuilder: (c, i) => ySpace(height: 24),
          ),
        ),
      ],
    );
  }

}
