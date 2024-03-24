import 'package:nodes/utilities/constants/exported_packages.dart';

class CustomTagChip extends StatelessWidget {
  const CustomTagChip({
    super.key,
    required this.title,
    this.color = TAG_CHIP,
  });

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color.withOpacity(0.1),
      ),
      child: labelText(
        title,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
