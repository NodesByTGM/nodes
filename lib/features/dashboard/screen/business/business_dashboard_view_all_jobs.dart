import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/dashboard/components/create_job_post.dart';
import 'package:nodes/features/dashboard/components/job_card.dart';
import 'package:nodes/features/saves/models/job_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class BusinessJobCenterScreen extends StatefulWidget {
  const BusinessJobCenterScreen({super.key});
  static const String routeName = "/business_job_center_screen";

  @override
  State<BusinessJobCenterScreen> createState() =>
      _BusinessJobCenterScreenState();
}

class _BusinessJobCenterScreenState extends State<BusinessJobCenterScreen> {
  @override
  Widget build(BuildContext context) {
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
                content: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (c, i) {
                    return const JobCard(
                      isFromBusiness: true,
                      job: JobModel(),
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
