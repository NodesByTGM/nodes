import 'package:flutter/material.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class TopicInterest extends StatefulWidget {
  const TopicInterest({super.key});

  @override
  State<TopicInterest> createState() => _TopicInterestState();
}

class _TopicInterestState extends State<TopicInterest> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              labelText(
                "Hi, Aderinsola! What topics interest you",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              ySpace(height: 24),
              subtext(
                "Please select at least 3 topics that interest you. You can always edit these later",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Container(
          height: screenHeight(context) - 300,
          padding: const EdgeInsets.only(bottom: 10, top: 20),
          decoration: const BoxDecoration(
            gradient: linearGradient,
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
