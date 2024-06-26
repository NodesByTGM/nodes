import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/business_account_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/components/create_job_post.dart';
import 'package:nodes/features/dashboard/components/job_card_business.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/standard_talent_job_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';
import 'package:nodes/utilities/widgets/shimmer_loader.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class BusinessCreatedJobCenterScreen extends StatefulWidget {
  const BusinessCreatedJobCenterScreen({super.key});
  static const String routeName = "/business_created_job_center_screen";

  @override
  State<BusinessCreatedJobCenterScreen> createState() =>
      _BusinessCreatedJobCenterScreenState();
}

class _BusinessCreatedJobCenterScreenState
    extends State<BusinessCreatedJobCenterScreen> {
  late DashboardController dashCtrl;

  @override
  void initState() {
    dashCtrl = locator.get<DashboardController>();
    super.initState();
    fetchMyCreatedJobs();
  }

  fetchMyCreatedJobs() {
    // Should be fetching all my created events
    safeNavigate(() => dashCtrl.fetchAllMyCreatedJobs(context));
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
                "Manage your job postings",
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
                        FormBuilderTextField(
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
                content: Consumer<DashboardController>(
                  builder: (contex, dashCtrl, _) {
                    bool isLoading = dashCtrl.isFetchingAllCreatedJobs;
                    bool hasData = isObjectEmpty(dashCtrl.createdJobList);
                    if (isLoading || isObjectEmpty(dashCtrl.createdJobList)) {
                      return DataReload(
                        maxHeight: screenHeight(context) * .19,
                        isLoading: isLoading,
                        label: "Try adding new jobs or",
                        loader: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ShimmerLoader(
                            scrollDirection: Axis.vertical,
                            width: screenWidth(context),
                            marginBottom: 10,
                          ),
                        ), // Pass the shimmer here...
                        onTap: fetchMyCreatedJobs,
                        isEmpty: hasData,
                      );
                    } else {
                      List<BusinessJobModel> jobs = dashCtrl.createdJobList;
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: jobs.length,
                        itemBuilder: (c, i) {
                          return BusinessJobCard(
                            // include the has delete, so i can delete the job straightup
                            // job: dashCtrl.createdJobList[i],
                            job: dashCtrl.createdJobList[i],
                            // Rethink this later, as when you create a job, it has the saved model...
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
                      // onPressed: showCreateJobBottomSheet,
                      onPressed: () {
                        BusinessAccountModel business = context
                                .read<AuthController>()
                                .currentUser
                                .business ??
                            const BusinessAccountModel();
                        if (isBusinessProfileComplete(business) &&
                            isBusinessVerified(business)) {
                          showCreateJobBottomSheet();
                        } else if (isBusinessProfileComplete(business) &&
                            !isBusinessVerified(business)) {
                          cantCreateMsg(i: 1);
                        } else {
                          cantCreateMsg();
                        }
                      },
                      title: btnTxt(
                        "Create a job posting",
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
            "Create a Job Post",
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          child: const CreateJobPost(),
        );
      },
    );
  }
}
