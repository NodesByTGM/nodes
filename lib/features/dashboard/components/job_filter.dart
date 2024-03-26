import 'package:multiple_search_selection/multiple_search_selection.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class JobFilter extends StatefulWidget {
  const JobFilter({super.key});

  @override
  State<JobFilter> createState() => _JobFilterState();
}

class _JobFilterState extends State<JobFilter> {
  List<String> selectedSkills = [];
  List<String>? initialPickedItems = [];

  @override
  void initState() {
    // Load the filtered values into the array, so when user filters and leaves, the data still persists...

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
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
          items: skillsList,
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
            fontSize: 12,
          ),
        ),
        ySpace(height: 24),
        labelText(
          "Job type",
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        ySpace(height: 16),
        ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: jobTypeOptions.length,
          itemBuilder: (c, i) {
            return GestureDetector(
              onTap: () {
                jobTypeOptions[i].status = !jobTypeOptions[i].status!;
                setState(() {});
              },
              child: SizedBox(
                height: 35,
                child: Wrap(
                  // spacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Checkbox(
                      value: jobTypeOptions[i].status,
                      onChanged: (val) {
                        jobTypeOptions[i].status = !jobTypeOptions[i].status!;
                        setState(() {});
                      },
                    ),
                    subtext(
                      "${jobTypeOptions[i].title}",
                      fontSize: 14,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        ySpace(height: 32),
        labelText(
          "Work Style",
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        ySpace(height: 16),
        ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: workStyleOptions.length,
          itemBuilder: (c, i) {
            return GestureDetector(
              onTap: () {
                workStyleOptions[i].status = !workStyleOptions[i].status!;
                setState(() {});
              },
              child: SizedBox(
                height: 35,
                child: Wrap(
                  // spacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Checkbox(
                      value: workStyleOptions[i].status,
                      onChanged: (val) {
                        workStyleOptions[i].status =
                            !workStyleOptions[i].status!;
                        setState(() {});
                      },
                    ),
                    subtext(
                      "${workStyleOptions[i].title}",
                      fontSize: 14,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        ySpace(height: 40),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: OutlineBtn(
                onPressed: resetOptions,
                borderColor: PRIMARY,
                child: btnTxt(
                  "Reset",
                  PRIMARY,
                ),
              ),
            ),
            xSpace(width: 16),
            Expanded(
              flex: 2,
              child: SubmitBtn(
                onPressed: () {
                  // Do something on the controller
                  navigateBack(context);
                },
                title: btnTxt(
                  "Filter",
                  WHITE,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  List<String> skillsList = const [
    'Production assitant',
    'Producer',
    'Production manager',
    'Project manager'
  ];

  void resetOptions() {
    for (JobFilterModel i in jobTypeOptions) {
      i.status = false;
    }
    for (JobFilterModel i in workStyleOptions) {
      i.status = false;
    }
    setState(() {});
  }

  List<JobFilterModel> jobTypeOptions = [
    JobFilterModel(title: "Contract", value: "contract", status: false),
    JobFilterModel(title: "Freelance", value: "freelance", status: false),
    JobFilterModel(title: "Full Time", value: "full_time", status: false),
    JobFilterModel(title: "Part Time", value: "part_time", status: false),
  ];
  List<JobFilterModel> workStyleOptions = [
    JobFilterModel(title: "Remote", value: "remote", status: false),
    JobFilterModel(title: "Hybrid", value: "hybrid", status: false),
    JobFilterModel(title: "On-site", value: "on_site", status: false),
  ];
}

class JobFilterModel {
  final String? title;
  final String? value;
  bool? status;

  JobFilterModel({
    required this.title,
    required this.value,
    required this.status,
  });
}
