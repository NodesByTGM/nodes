import 'package:nodes/utilities/constants/exported_packages.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({
    super.key,
    this.isFromBusiness = false,
  });

  final bool isFromBusiness;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ySpace(height: 27),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: WHITE,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 0.7,
              color: BORDER,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              infoItem(
                icon: ImageUtils.mapMarkerOutlineIcon,
                title: "Lagos | Nigeria",
              ),
              ySpace(height: 19),
              infoItem(
                icon: ImageUtils.clockOutlineIcon,
                title: timOfDay(TimeOfDay.now()),
              ),
              ySpace(height: 19),
              infoItem(
                icon: ImageUtils.calendarOutlineIcon,
                title: shortDate(DateTime.now()),
              ),
              ySpace(height: 19),
              infoItem(
                icon: ImageUtils.cardOutlineIcon,
                title: "Free",
              ),
              ySpace(height: 19),
            ],
          ),
        ),
        ySpace(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: WHITE,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 0.7,
              color: BORDER,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelText(
                "Other details",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              ySpace(height: 24),
              subtext(
                "Lorem ipsum dolor sit amet consectetur. Tincidunt sit mattis pellentesque imperdiet etiam curabitur. Sit vitae vel et justo egestas sit enim turpis. Blandit in ullamcorper non vel volutpat. Quam condimentum faucibus auctor mattis sed consectetur viverra.\n\n\nLorem ipsum dolor sit amet consectetur. Tincidunt sit mattis pellentesque imperdiet etiam curabitur. Sit vitae vel et justo egestas sit enim turpis. Blandit in ullamcorper non vel volutpat. Quam condimentum faucibus auctor mattis sed consectetur viverra.\n\nLorem ipsum dolor sit amet consectetur. Tincidunt sit mattis pellentesque imperdiet etiam curabitur. Sit vitae vel et justo egestas sit enim turpis. Blandit in ullamcorper non vel volutpat. Quam condimentum faucibus auctor mattis sed consectetur viverra.\n\n\nLorem ipsum dolor sit amet consectetur. Tincidunt sit mattis pellentesque imperdiet etiam curabitur. Sit vitae vel et justo egestas sit enim turpis. Blandit in ullamcorper non vel volutpat. Quam condimentum faucibus auctor mattis sed consectetur viverra.",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Wrap infoItem({
    required String icon,
    required String title,
  }) {
    return Wrap(
      spacing: 5,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SvgPicture.asset(icon),
        labelText(
          title,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
