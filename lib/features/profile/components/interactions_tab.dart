import 'package:nodes/features/profile/components/profile_cards.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class InteractionsTab extends StatelessWidget {
  const InteractionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 20,
      itemBuilder: (c, i) {
        return CustomDottedBorder(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelText(
                "Jane Doe created a space called “insert name of space”",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              ySpace(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cachedNetworkImage(
                    imgUrl:
                        "https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg",
                    size: 40,
                  ),
                  xSpace(width: 10),
                  Expanded(
                    child: subtext(
                      "Lorem ipsum dolor sit amet consectetur. Libero adipiscing phasellus interdum ullamcorper sed amet netus iaculis.",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (c, i) => ySpace(height: 40),
    );
  }
}
