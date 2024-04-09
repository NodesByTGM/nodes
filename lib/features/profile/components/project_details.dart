import 'package:nodes/features/auth/models/media_upload_model.dart';
import 'package:nodes/features/dashboard/model/project_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class ProjectDetails extends StatefulWidget {
  const ProjectDetails({super.key, required this.project});

  final ProjectModel project;

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  late ProjectModel project;

  @override
  void initState() {
    project = widget.project;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              labelText(
                "Project details",
              ),
              GestureDetector(
                onTap: () {
                  navigateBack(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.cancel,
                    color: PRIMARY,
                    size: 35,
                  ),
                ),
              ),
            ],
          ),
          ySpace(height: 12),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  width: screenWidth(context),
                  height: 160,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: cachedNetworkImage(
                      imgUrl: '${project.thumbnail?.url}',
                    ),
                  ),
                ),
                ySpace(height: 16),
                titleFn('Project name'),
                ySpace(height: 5),
                contentFn("${project.name}"),
                ySpace(height: 24),
                titleFn("Description"),
                ySpace(height: 5),
                contentFn("${project.description}"),
                ySpace(height: 24),
                titleFn(
                  "Project URL",
                ),
                ySpace(height: 5),
                contentFn("${project.projectURL}"),
                ySpace(height: 24),
                titleFn(
                  "Collaborators",
                ),
                ySpace(height: 5),
                //
                // 1. Name of Collaborator...
                //
                ...getCollaborators(),
                ySpace(height: 24),
                titleFn(
                  "Project images",
                ),
                ySpace(height: 5),
                isObjectEmpty(project.images)
                    ? Container(
                        child: Center(
                          child: subtext(
                            "No Project Images were provided.",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 150,
                        child: ListView.separated(
                          itemCount: project.images!.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (c, i) {
                            MediaUploadModel img = project.images![i];
                            return SizedBox(
                              height: 180,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: cachedNetworkImage(
                                  imgUrl: img.url,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (c, i) => xSpace(width: 8),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getCollaborators() {
    if (isObjectEmpty(project.collaborators)) {
      return SizedBox(
        child: Center(
          child: subtext(
            "No collaborator(s)  added yet.",
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    List<Widget> _ = [];
    // for (var f in (project.collaborators!)) {
    for (var i = 0; i < (project.collaborators!).length; i++) {
      CollaboratorModel c = project.collaborators![i];
      _.add(
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          visualDensity: VisualDensity.compact,
          leading: subtext(
            '${i + 1}',
          ),
          title: labelText(
            "${c.name}",
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          subtitle: subtext(
            "${c.role}",
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }
    return _;
  }

  Text contentFn(String content) {
    return subtext(
      content,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }

  Text titleFn(String title) {
    return labelText(
      title,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    );
  }
}
