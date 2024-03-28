import 'package:nodes/utilities/constants/exported_packages.dart';

class ProjectDetails extends StatefulWidget {
  const ProjectDetails({super.key});

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
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
                      imgUrl:
                          'https://m.media-amazon.com/images/M/MV5BN2EwM2I5OWMtMGQyMi00Zjg1LWJkNTctZTdjYTA4OGUwZjMyXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_.jpg',
                    ),
                  ),
                ),
                ySpace(height: 16),
                titleFn('Project name'),
                ySpace(height: 5),
                contentFn("Lorem ipsum"),
                ySpace(height: 24),
                titleFn(
                  "Description",
                ),
                ySpace(height: 5),
                contentFn(
                    "Lorem ipsum dolor sit amet consectetur. Cum amet id lectus viverra faucibus. Arcu eget hendrerit ut dictumst id. Lorem ipsum dolor sit amet consectetur. Cum amet id lectus viverra faucibus. Arcu eget hendrerit ut dictumst id. Lorem ipsum dolor sit amet consectetur. Cum amet id lectus viverra faucibus. Arcu eget hendrerit ut dictumst id. "),
                ySpace(height: 24),
                titleFn(
                  "Project URL",
                ),
                ySpace(height: 5),
                contentFn("http://urlblahblahblah.com"),
                ySpace(height: 24),
                titleFn(
                  "Project URL",
                ),
                ySpace(height: 5),
                contentFn("http://urlblahblahblah.com"),
                ySpace(height: 24),
                titleFn(
                  "Collaborators",
                ),
                ySpace(height: 5),
                //
                // 1. Name of Collaborator...
                //
                ySpace(height: 24),
                titleFn(
                  "Project images",
                ),
                ySpace(height: 5),
                SizedBox(
                  height: 150,
                  child: ListView.separated(
                    itemCount: 5,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (c, i) {
                      return SizedBox(
                        height: 180,
                        width: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: cachedNetworkImage(
                            imgUrl:
                                'https://m.media-amazon.com/images/M/MV5BN2EwM2I5OWMtMGQyMi00Zjg1LWJkNTctZTdjYTA4OGUwZjMyXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_.jpg',
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
