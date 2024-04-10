import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/dashboard/components/create_event.dart';
import 'package:nodes/features/dashboard/components/event_card.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class BusinessEventCenterScreen extends StatefulWidget {
  const BusinessEventCenterScreen({super.key});
  static const String routeName = "/business_event_center_screen";

  @override
  State<BusinessEventCenterScreen> createState() =>
      _BusinessEventCenterScreenState();
}

class _BusinessEventCenterScreenState extends State<BusinessEventCenterScreen> {
  late DashboardController dashCtrl;

  @override
  void initState() {
    dashCtrl = locator.get<DashboardController>();
    super.initState();
    fetchJobs();
  }

  fetchJobs() {
    // Should be fetching all my created events
    safeNavigate(() => dashCtrl.fetchAllEvents(context));
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
            padding: const EdgeInsets.only(top: 40, bottom: 100),
            children: [
              labelText(
                "Manage your events",
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
                    child: FormBuilderTextField(
                      name: "eventSearch",
                      decoration: FormUtils.formDecoration(
                        hintText: "Search for events",
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
                  );
                },
                content: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dashCtrl.eventsList.length,
                  itemBuilder: (c, i) {
                    return SizedBox(
                      height: 280,
                      child: EventCard(
                        isFromBusiness: true,
                        hasDelete: true,
                        hasSave: false,
                        event: dashCtrl.eventsList[i],
                      ),
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
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        context.read<NavController>().popPageListStack();
                      },
                      child: labelText(
                        "Go Back",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  xSpace(width: 16),
                  Expanded(
                    flex: 2,
                    child: SubmitBtn(
                      onPressed: showCreateJobBottomSheet,
                      title: btnTxt(
                        "Create an event",
                        WHITE,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showCreateJobBottomSheet() {
    showModalBottomSheet(
      context: context,
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
        return BottomSheetWrapper(
          closeOnTap: true,
          title: labelText(
            "Create an event",
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          child: const CreateEvent(),
        );
      },
    );
  }
}
