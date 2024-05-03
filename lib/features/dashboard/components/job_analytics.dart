import 'package:nodes/features/saves/models/standard_talent_job_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class JobAnalytics extends StatefulWidget {
  const JobAnalytics({super.key, required this.job});

  final BusinessJobModel job;

  @override
  State<JobAnalytics> createState() => _JobAnalyticsState();
}

class _JobAnalyticsState extends State<JobAnalytics> {
  late BusinessJobModel job;

  @override
  void initState() {
    job = widget.job;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 40),
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            padding: const EdgeInsets.only(
              top: 4,
              bottom: 4,
              left: 10,
              right: 2,
            ),
            decoration: BoxDecoration(
              color: WHITE,
              border: Border.all(width: 0.7, color: BORDER),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 5,
              children: [
                labelText(
                  "Sort by:",
                  color: GRAY,
                  fontSize: 12,
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {},
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 'Today',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            subtext("Today"),
                          ],
                        ),
                      )
                    ];
                  },
                  offset: const Offset(0, 40),
                  color: WHITE,
                  elevation: 2,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      labelText(
                        "Today",
                        fontSize: 12,
                      ),
                      const Icon(
                        Icons.arrow_drop_down_outlined,
                        color: BORDER,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ySpace(height: 24),
        Row(
          children: [
            Expanded(
              child: analyticsCard(
                title: "No. of Clicks",
                value: "0",
              ),
            ),
            xSpace(width: 24),
            Expanded(
              child: analyticsCard(
                title: "No. of Saves",
                value: "${job.saves?.length}",
              ),
            ),
          ],
        ),
        ySpace(height: 24),
        analyticsCard(
          title: "No. of Applicants",
          value: "${job.applicants?.length}",
        ),
      ],
    );
  }
}
