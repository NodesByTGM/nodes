import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/components/job_card.dart';
import 'package:nodes/features/dashboard/components/job_filter.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
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
  late DashboardController dashCtrl;
  late AuthController authCtrl;

  @override
  void initState() {
    dashCtrl = locator.get<DashboardController>();
    authCtrl = locator.get<AuthController>();
    super.initState();
    fetchAllJobs();
  }

  fetchAllJobs() {
    // Should be fetching all my created events
    safeNavigate(() => dashCtrl.fetchAllJobs(context));
  }

  @override
  Widget build(BuildContext context) {
    dashCtrl = context.watch<DashboardController>();
    return Container(
      // padding: screenPadding,
      // decoration: const BoxDecoration(
      //   gradient: profileLinearGradient,
      // ),
      child: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.only(bottom: 120),
            children: [
              ySpace(height: 20),
              labelText(
                "Hi, ${authCtrl.currentUser.name?.split(" ").first}! Welcome to the Nodes Job center",
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: FormBuilderTextField(
                                name: "jobSearch",
                                decoration: FormUtils.formDecoration(
                                  hintText: "Search for jobs",
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
                            xSpace(width: 30),
                            // const Spacer()
                            GestureDetector(
                              onTap: () => showFilterBox(context),
                              child: Container(
                                margin: const EdgeInsets.only(right: 6),
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                  left: 10,
                                  right: 15,
                                ),
                                decoration: BoxDecoration(
                                  color: WHITE,
                                  border:
                                      Border.all(width: 0.7, color: PRIMARY),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 5,
                                  children: [
                                    Icon(
                                      MdiIcons.filterOutline,
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
                          ],
                        ),
                        ySpace(height: 8),
                        // Hide this at a certain scrool George...
                        subtext(
                          "You can search based on skill, roles and job type",
                          fontSize: 14,
                          color: GRAY,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  );
                },
                content: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dashCtrl.jobsList.length,
                  itemBuilder: (c, i) {
                    return JobCard(
                      job: dashCtrl.jobsList[i],
                    );
                  },
                  separatorBuilder: (c, i) => ySpace(height: 24),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: screenWidth(context),
              padding: const EdgeInsets.only(top: 10, bottom: 30),
              decoration: const BoxDecoration(
                color: WHITE,
                border: Border(
                  top: BorderSide(width: 0.7, color: BORDER),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  customNavigateBack(context);
                },
                child: labelText(
                  "Go Back",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showFilterBox(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      backgroundColor: WHITE,
      elevation: 0.0,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return BottomSheetWrapper(
              closeOnTap: true,
              title: labelText(
                "Filter",
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              child: const JobFilter(),
            );
          },
        );
      },
    );
  }
}
