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
                  "Unleash the power of creativity with Nodes Grid Tools.",
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
                ySpace(height: 24),
                subtext(
                  "Your bridge between creativity and the pragmatic world of business",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  height: 1.5,
                ),
                ySpace(height: 24),
                SizedBox(
                  width: 200,
                  child: SubmitBtn(
                    onPressed: () {
                      showSuccess(message: "Comming Soon");
                    },
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
            child: Image.asset(ImageUtils.gridToolsImg),
          ),
        ],
      ),
    );
  }
}
