import 'package:nodes/utilities/constants/exported_packages.dart';

class CardDotIndicator extends StatelessWidget {
  const CardDotIndicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: screenDuration,
      height: 10,
      width: isActive ? 15 : 10,
      decoration: BoxDecoration(
        color: isActive ? BLACK : BORDER,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
