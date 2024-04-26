import 'package:flutter/widgets.dart';
import 'package:nodes/features/dashboard/components/dot_indicator.dart';

class CardDotGenerator extends StatelessWidget {
  const CardDotGenerator({
    super.key,
    this.length = 5,
    required this.currentIndex,
  });

  final int length;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ...List.generate(
          length,
          (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 2),
              child: CardDotIndicator(
                isActive: currentIndex == index,
              ),
            );
          },
        ),
      ],
    );
  }
}
