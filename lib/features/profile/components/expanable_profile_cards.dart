import 'package:expandable_section/expandable_section.dart';
import 'package:nodes/features/profile/components/profile_cards.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class ExpanableProfileCard extends StatefulWidget {
  const ExpanableProfileCard({
    super.key,
    required this.isExpanded,
    required this.child,
    required this.title,
    this.errorText,
    this.canOpen = true,
  });
  final bool isExpanded;
  final Widget child;
  final String title;

  //
  final String? errorText;
  final bool canOpen;

  @override
  State<ExpanableProfileCard> createState() => _ExpanableProfileCardState();
}

class _ExpanableProfileCardState extends State<ExpanableProfileCard> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      padding: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: labelText(
              widget.title,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            trailing: Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            ),
            onTap: () {
              if (widget.canOpen) {
                setState(() {
                  isExpanded = !isExpanded;
                });
              } else {
                showText(message: widget.errorText ?? '');
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: ExpandableSection(
              expand: isExpanded,
              child: widget.child,
            ),
          )
        ],
      ),
    );
  }
}
