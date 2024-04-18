import 'package:nodes/features/saves/models/event_model_standardTalent.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class StandardTalentEventDetails extends StatefulWidget {
  const StandardTalentEventDetails({
    super.key,
    required this.event,
  });

  final StandardTalentEventModel event;

  @override
  State<StandardTalentEventDetails> createState() =>
      _StandardTalentEventDetailsState();
}

class _StandardTalentEventDetailsState
    extends State<StandardTalentEventDetails> {
  late StandardTalentEventModel event;

  @override
  void initState() {
    event = widget.event;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        if (!isObjectEmpty(event.thumbnail)) ...[
          SizedBox(
            height: 250,
            child: cachedNetworkImage(
              imgUrl: "${event.thumbnail?.url}",
              size: screenWidth(context),
            ),
          ),
        ],
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
              infoItem(
                icon: ImageUtils.mapMarkerOutlineIcon,
                title: capitalize("${event.location}"),
              ),
              ySpace(height: 19),
              infoItem(
                icon: ImageUtils.clockOutlineIcon,
                // title: fromDatTimeToTimeOfDay(event.eventTime ?? DateTime.now()),
                title: fromDatTimeToTimeOfDay(event.dateTime ?? DateTime.now()),
              ),
              ySpace(height: 19),
              infoItem(
                icon: ImageUtils.calendarOutlineIcon,
                title: shortDate(event.dateTime ?? DateTime.now()),
              ),
              ySpace(height: 19),
              infoItem(
                icon: ImageUtils.cardOutlineIcon,
                // title: "Free",
                title: capitalize("${event.paymentType}"),
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
                "${event.description}",
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
