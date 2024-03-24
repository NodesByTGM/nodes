import 'package:flutter/material.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_screen.dart';
import 'package:nodes/features/dashboard/screen/individual/individual_dashboard_screen.dart';
import 'package:nodes/features/dashboard/screen/talent/talent_dashboard_screen.dart';
import 'package:nodes/utilities/constants/colors.dart';

class DashboardWrapper extends StatelessWidget {
  const DashboardWrapper({super.key});
  static const String routeName = "/dashboard_wrapper";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: PROFILEBG,
      ),
      child: getDashboard(),
    );
  }

  Widget getDashboard() {
    switch (2) {
      case 1:
        return const IndividualDashboardScreen();
      case 2:
        return const TalentDashboardScreen();
      case 3:
        return const BusinessDashboardScreen();
      default:
        return const IndividualDashboardScreen();
    }
  }
}
