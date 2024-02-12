import 'package:nodes/utilities/constants/exported_packages.dart';

class PricePlanCard extends StatelessWidget {
  const PricePlanCard({
    super.key,
    required this.type,
    required this.description,
    required this.icon,
    required this.price,
    required this.priceDescription,
    required this.features,
    required this.onTap,
    required this.btnText,
  });

  final String type;
  final String description;
  final String icon;
  final Widget price;
  final String priceDescription;
  final List<String> features;
  final GestureCancelCallback onTap;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        color: WHITE,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: labelText(
              type,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            subtitle: subtext(
              description,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            trailing: SvgPicture.asset(
              icon,
              height: 53,
            ),
          ),
          ySpace(height: 26),
          price,
          ySpace(height: 16),
          labelText(
            priceDescription,
            fontSize: 14,
            color: GRAY,
            fontWeight: FontWeight.w500,
          ),
          divider(),
          // Using the spread operator
          ...getFeatures(),
          ySpace(height: 24),
          SubmitBtn(
            onPressed: onTap,
            title: btnTxt(btnText, WHITE),
            rightIcon: const Icon(
              Icons.arrow_forward,
              color: WHITE,
            ),
          ),
          ySpace(height: 24),
        ],
      ),
    );
  }

  Divider divider() {
    return const Divider(
      thickness: 0.3,
      height: 40,
      color: GRAY,
    );
  }

  getFeatures() {
    if (isObjectEmpty(features)) return Container();
    List<Widget> _ = [];
    for (var f in features) {
      _.add(ListTile(
        contentPadding: const EdgeInsets.all(0),
        visualDensity: VisualDensity.compact,
        leading: Icon(
          Icons.check_circle,
          size: 30,
          color: GRAY.withOpacity(0.4),
        ),
        title: labelText(
          f,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ));
    }
    return _;
  }
}
