import 'package:nodes/utilities/constants/exported_packages.dart';

class GridToolsScreen extends StatelessWidget {
  const GridToolsScreen({super.key});

  static const String routeName = "/grid_tools";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                labelText(
                  "Grid Tools",
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                ySpace(height: 24),
                labelText(
                  "We believe in the power of every individual's creative spark. Join our thriving community of actors, artists, designers, writers, and visionaries. Your journey to success starts here.",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  height: 1.5,
                ),
                ySpace(height: 24),
                SizedBox(
                  width: 200,
                  child: SubmitBtn(
                    onPressed: () {},
                    title: btnTxt(
                      "Check it out",
                      WHITE,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(ImageUtils.talentAuthImage),
          ),
        ],
      ),
    );
  }
}
