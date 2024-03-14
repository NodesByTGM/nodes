import 'package:nodes/features/profile/components/add_project.dart';
import 'package:nodes/features/profile/components/profile_cards.dart';
import 'package:nodes/features/profile/components/project_details.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class ProjectsTab extends StatefulWidget {
  const ProjectsTab({
    super.key,
    this.isBusiness = false,
  });
// use enum to detect if it's the
// Job/Event
// Project

  final bool isBusiness;

  @override
  State<ProjectsTab> createState() => _ProjectsTabState();
}

class _ProjectsTabState extends State<ProjectsTab> {
  @override
  Widget build(BuildContext context) {
    return 1 > 2
        ? Container(
            color: WHITE,
            height: 200,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ySpace(height: 20),
                    labelText(
                      "Hi Aderinsola!",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    ySpace(height: 20),
                    subtext(
                      "Nothing to see here yet,\nadd a project or two to get started.",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                    ySpace(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48.0),
                      child: SubmitBtn(
                        onPressed: showCreateProjectModal,
                        title: btnTxt(
                          "Add projects",
                          WHITE,
                        ),
                      ),
                    ),
                    ySpace(height: 40),
                    SvgPicture.asset(ImageUtils.spaceEmptyIcon),
                  ],
                ),
              ),
            ),
          )
        : ProfileCard(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 5,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (c, i) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screenWidth(context),
                      height: widget.isBusiness ? 160 : 96,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: cachedNetworkImage(
                          imgUrl:
                              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
                        ),
                      ),
                    ),
                    ySpace(height: 16),
                    labelText(
                      "Name  of project",
                      fontSize: 14,
                    ),
                    ySpace(height: 10),
                    subtext(
                      "Lorem ipsum dolor sit amet consectetur. Cum amet id lectus viverra faucibus. Arcu eget hendrerit ut dictumst id. Lorem ipsum dolor sit amet consectetur. Cum amet id lectus viverra faucibus. Arcu eget hendrerit ut dictumst id. Lorem ipsum dolor sit amet consectetur. Cum amet id lectus viverra faucibus. Arcu eget hendrerit ut dictumst id. ",
                    ),
                    ySpace(height: 24),
                    if (widget.isBusiness) ...[
                      GestureDetector(
                        onTap: () {},
                        child: subtext(
                          "See more",
                          fontSize: 14,
                          textDecoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                    if (!widget.isBusiness) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => showProjectDetailsModal(),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: BLACK,
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.edit_outlined,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: RED,
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.delete_outline,
                                  color: RED,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ],
                );
              },
              separatorBuilder: (c, i) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: dottedLines(),
              ),
              // separatorBuilder: (c, i) => ySpace(height: 40),
            ),
          );
  }

  showProjectDetailsModal() async {
    showSimpleDialog(
      context: context,
      backgroundColor: WHITE,
      // dismissable: false,
      dismissable: true,
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(bottom: 0),
      child: const ProjectDetails(),
    );
  }

  showCreateProjectModal() async {
    showSimpleDialog(
      context: context,
      backgroundColor: Colors.white,
      // dismissable: false,
      dismissable: true,
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(bottom: 0),
      child: const AddProject(),
    );
  }
}
