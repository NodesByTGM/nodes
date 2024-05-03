import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/business_account_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/components/create_event.dart';
import 'package:nodes/features/dashboard/components/event_card.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/event_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';
import 'package:nodes/utilities/widgets/shimmer_loader.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class BusinessCreatedEventCenterScreen extends StatefulWidget {
  const BusinessCreatedEventCenterScreen({super.key});
  static const String routeName = "/business_created_event_center_screen";

  @override
  State<BusinessCreatedEventCenterScreen> createState() =>
      _BusinessCreatedEventCenterScreenState();
}

class _BusinessCreatedEventCenterScreenState
    extends State<BusinessCreatedEventCenterScreen> {
  late DashboardController dashCtrl;

  @override
  void initState() {
    dashCtrl = locator.get<DashboardController>();
    super.initState();
    fetchMyCreatedEvents();
  }

  fetchMyCreatedEvents() {
    // Should be fetching all my created events
    safeNavigate(() => dashCtrl.fetchAllAllMyCreatedEvents(context));
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
                content: Consumer<DashboardController>(
                  builder: (contex, dashCtrl, _) {
                    bool isLoading = dashCtrl.isFetchingAllCreatedEvents;
                    bool hasData = isObjectEmpty(dashCtrl.myCreatedEventsList);
                    if (isLoading ||
                        isObjectEmpty(dashCtrl.myCreatedEventsList)) {
                      return DataReload(
                        maxHeight: screenHeight(context) * .19,
                        isLoading: isLoading,
                        label: "Try adding new events or",
                        loader: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ShimmerLoader(
                            scrollDirection: Axis.vertical,
                            width: screenWidth(context),
                            marginBottom: 10,
                          ),
                        ), // Pass the shimmer here...
                        onTap: fetchMyCreatedEvents,
                        isEmpty: hasData,
                      );
                    } else {
                      List<EventModel> events = dashCtrl.myCreatedEventsList;
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: events.length,
                        itemBuilder: (c, i) {
                          return SizedBox(
                            height: 280,
                            child: EventCard(
                              event: events[i],
                            ),
                          );
                        },
                        separatorBuilder: (c, i) => ySpace(height: 24),
                      );
                    }
                  },
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
                  xSpace(width: 16),
                  Expanded(
                    flex: 2,
                    child: SubmitBtn(
                      onPressed: showCreateEventBottomSheet,
                      // onPressed: () {
                      //   BusinessAccountModel business =
                      //       context.read<AuthController>().currentUser.business ?? const BusinessAccountModel();
                      //   if (isBusinessProfileComplete(business) &&
                      //       isBusinessVerified(business)) {
                      //     showCreateEventBottomSheet();
                      //   } else if (isBusinessProfileComplete(business) &&
                      //       !isBusinessVerified(business)) {
                      //     cantCreateMsg(i: 1);
                      //   } else {
                      //     cantCreateMsg();
                      //   }
                      // },
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

  void cantCreateMsg({int i = 0}) {
    showText(
        message: i == 0
            ? Constants.updateYourProfileToProceed
            : Constants.accountNotVerified);
  }

  showCreateEventBottomSheet() {
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
