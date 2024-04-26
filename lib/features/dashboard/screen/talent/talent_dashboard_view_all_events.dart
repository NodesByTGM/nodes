import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/components/event_card_standardTalent.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/event_model_standardTalent.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';
import 'package:nodes/utilities/widgets/shimmer_loader.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class TalentEventCenterScreen extends StatefulWidget {
  const TalentEventCenterScreen({super.key});
  static const String routeName = "/talent_event_center_screen";

  @override
  State<TalentEventCenterScreen> createState() =>
      _TalentEventCenterScreenState();
}

class _TalentEventCenterScreenState extends State<TalentEventCenterScreen> {
  late DashboardController dashCtrl;
  late AuthController authCtrl;

  @override
  void initState() {
    dashCtrl = locator.get<DashboardController>();
    authCtrl = locator.get<AuthController>();
    super.initState();
    fetchAllEvents();
  }

  fetchAllEvents() {
    // Should be fetching all my events
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
            padding: const EdgeInsets.only(bottom: 120),
            children: [
              ySpace(height: 20),
              labelText(
                "Hi, ${authCtrl.currentUser.name?.split(" ").first}! Welcome to the Nodes Event center",
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
                            ),
                          ],
                        ),
                        ySpace(height: 8),
                        subtext(
                          "You can search based on Businesses or Event title",
                          fontSize: 14,
                          color: GRAY,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  );
                },
                content: Consumer<DashboardController>(
                  builder: (contex, dCtrl, _) {
                    bool isLoading = dCtrl.isFetchingAllEvent;
                    bool hasData = isObjectEmpty(dCtrl.eventsList);
                    if (isLoading || isObjectEmpty(dCtrl.eventsList)) {
                      return DataReload(
                        maxHeight: screenHeight(context) * .19,
                        isLoading: isLoading,
                        label: "Oops!! No listed jobs yet.",
                        loader: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ShimmerLoader(
                            scrollDirection: Axis.vertical,
                            width: screenWidth(context),
                            marginBottom: 10,
                          ),
                        ),
                        onTap: fetchAllEvents,
                        isEmpty: hasData,
                      );
                    } else {
                      List<StandardTalentEventModel> eventsList =
                          dCtrl.eventsList;
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: eventsList.length,
                        itemBuilder: (c, i) {
                          StandardTalentEventModel event = eventsList[i];
                          return SizedBox(
                            height: 320,
                            child: StandardTalentEventCard(
                              event: event,
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
}
