import 'package:nodes/utilities/constants/exported_packages.dart';

class CommunityFilter extends StatefulWidget {
  const CommunityFilter({super.key});

  @override
  State<CommunityFilter> createState() => _CommunityFilterState();
}

class _CommunityFilterState extends State<CommunityFilter> {
  String peopleOrBrand = "People";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: screenWidth(context),
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  labelText(
                    "Filter",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      // Make the filter call to switch to the selected value...
                      setState(() {
                        peopleOrBrand = capitalize(value);
                      });
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 'people',
                          child: subtext(
                            "People",
                          ),
                        ),
                        PopupMenuItem(
                          value: 'brand',
                          child: subtext(
                            "Brand",
                          ),
                        ),
                      ];
                    },
                    offset: const Offset(0, 40),
                    color: WHITE,
                    elevation: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.8,
                          color: BORDER,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Wrap(
                        spacing: 5,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          labelText(
                            peopleOrBrand,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          const Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                  ),
                  labelText(
                    "by",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              ySpace(height: 24),
              labelText(
                "Categories",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              const Divider(),
            ],
          ),
        ),
        Container(
          height: screenHeight(context) - 300,
          padding: const EdgeInsets.only(bottom: 10, top: 2),
          decoration: const BoxDecoration(
            // gradient: linearGradient,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            itemCount: topicArr.length,
            itemBuilder: (c, i) {
              String title = topicArr[i]['title'];
              bool isSelected = topicArr[i]['isSelected'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    topicArr[i]['isSelected'] = !topicArr[i]['isSelected'];
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: BORDER),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: isSelected,
                        onChanged: (val) {
                          setState(() {
                            topicArr[i]['isSelected'] = val;
                          });
                        },
                      ),
                      xSpace(width: 10),
                      Expanded(
                        child: labelText(title),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 80,
            vertical: 10,
          ),
          child: SubmitBtn(
            onPressed: () {
              navigateBack(context);
            },
            title: btnTxt("Continue", WHITE),
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> topicArr = [
    {
      "title": "Acting / Performing",
      "isSelected": false,
    },
    {
      "title": "Movie Production / Directing.",
      "isSelected": false,
    },
    {
      "title": "Fashion Design / Styling",
      "isSelected": false,
    },
    {
      "title": "Photography / Videography.",
      "isSelected": false,
    },
    {
      "title": "Culinary Arts / Cooking.",
      "isSelected": false,
    },
    {
      "title": "Modeling / Runway.",
      "isSelected": false,
    },
    {
      "title": "Writing / Scripting.",
      "isSelected": false,
    },
    {
      "title": "Makeup Artistry.",
      "isSelected": false,
    },
    {
      "title": "Set Design / Art Direction.",
      "isSelected": false,
    },
    {
      "title": "Music / Sound Production.",
      "isSelected": false,
    },
  ];
}
