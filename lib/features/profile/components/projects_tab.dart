import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/business_account_model.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/model/project_model.dart';
import 'package:nodes/features/profile/components/add_project_modal.dart';
import 'package:nodes/features/profile/components/profile_cards.dart';
import 'package:nodes/features/profile/components/project_details.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class ProjectsTab extends StatefulWidget {
  const ProjectsTab({
    super.key,
    this.isBusiness = false,
    this.isGuest = false,
    required this.projects,
  });
// use enum to detect if it's the
// Job/Event
// Project

  final bool isBusiness;
  final bool isGuest;
  final List<ProjectModel> projects;

  @override
  State<ProjectsTab> createState() => _ProjectsTabState();
}

class _ProjectsTabState extends State<ProjectsTab> {
  late AuthController authCtrl;
  late UserModel user;
  late BusinessAccountModel business;
  late List<ProjectModel> projects;

  @override
  void initState() {
    authCtrl = locator.get<AuthController>();
    user = authCtrl.currentUser;
    business = user.business as BusinessAccountModel;
    projects = widget.projects;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
    return isObjectEmpty(projects)
        ? Container(
            color: WHITE,
            // height: 200,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ySpace(height: 20),
                    labelText(
                      "Hi ${user.name?.split(" ").first}!",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    ySpace(height: 20),
                    subtext(
                      !widget.isGuest
                          ? "Nothing to see here yet,\nadd a project or two to get started."
                          : "Nothing to see here yet.",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                    ySpace(height: 40),
                    if (!widget.isGuest) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48.0),
                        child: SubmitBtn(
                          // onPressed: showCreateProjectModal,
                          onPressed: () {
                            if (widget.isBusiness) {
                              if (isBusinessProfileComplete(business) &&
                                  isBusinessVerified(business)) {
                                showCreateProjectModal();
                              } else if (isBusinessProfileComplete(business) &&
                                  !isBusinessVerified(business)) {
                                showText(
                                  message: Constants.accountNotVerified,
                                );
                              } else {
                                showText(
                                  message: Constants.updateYourProfileToProceed,
                                );
                              }
                            } else if (isTalentProfileComplete(user)) {
                              showCreateProjectModal();
                            } else {
                              showText(
                                  message:
                                      Constants.updateYourProfileToProceed);
                            }
                          },
                          title: btnTxt(
                            "Add projects",
                            WHITE,
                          ),
                        ),
                      ),
                      ySpace(height: 40),
                    ],
                    SvgPicture.asset(ImageUtils.spaceEmptyIcon),
                  ],
                ),
              ),
            ),
          )
        : ProfileCard(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: projects.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (c, i) {
                ProjectModel project = projects[i];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screenWidth(context),
                      height: widget.isBusiness ? 160 : 96,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: cachedNetworkImage(
                          imgUrl: '${project.thumbnail?.url}',
                        ),
                      ),
                    ),
                    ySpace(height: 16),
                    labelText(
                      "${project.name}",
                      fontSize: 14,
                    ),
                    ySpace(height: 10),
                    subtext(
                      "${project.description}",
                    ),
                    ySpace(height: 24),
                    // if (widget.isBusiness ) ...[
                    if (widget.isBusiness && !(widget.isGuest)) ...[
                      // Meaning its a business account, and not viewing in Guest Mode.
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
                      // if (!widget.isBusiness && !(widget.isGuest)) ...[
                      // Meaning it's NOT a business account, and also not viewing in uest Mode.
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => showProjectDetailsModal(project),
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
                          if (!(widget.isGuest)) ...[
                            // Meaning it's not being viewed in Guest Mode
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

  showProjectDetailsModal(ProjectModel project) async {
    showSimpleDialog(
      context: context,
      backgroundColor: WHITE,
      // dismissable: false,
      dismissable: true,
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(bottom: 0),
      child: ProjectDetails(project: project),
    );
  }

  showCreateProjectModal() async {
    showSimpleDialog(
      context: context,
      backgroundColor: Colors.white,
      dismissable: true,
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(bottom: 0),
      child: AddProject(isBusiness: widget.isBusiness),
    );
  }
}
