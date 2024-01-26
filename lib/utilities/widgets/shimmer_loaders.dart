// import 'package:nodes/utilities/constants/exported_packages.dart';
// import 'package:shimmer/shimmer.dart';

// class EventCardShimmer extends StatelessWidget {
//   const EventCardShimmer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey.shade300,
//       highlightColor: Colors.grey.shade100,
//       child: SizedBox(
//         height: 200,
//         child: ListView.separated(
//           shrinkWrap: true,
//           scrollDirection: Axis.horizontal,
//           itemCount: 4,
//           padding: const EdgeInsets.all(0),
//           itemBuilder: (context, index) {
//             return Container(
//               height: 200,
//               width: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5),
//                 color: WHITE,
//               ),
//             );
//           },
//           separatorBuilder: (context, index) => xSpace(width: 10),
//         ),
//       ),
//     );
//   }
// }
