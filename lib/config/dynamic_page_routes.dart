import 'package:flutter/material.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/community/screens/nodes_spaces_screen.dart';
import 'package:nodes/features/community/screens/space_details_screen.dart';
import 'package:nodes/features/dashboard/screen/dashboard_screen.dart';
import 'package:nodes/features/dashboard/screen/dashboard_single_item_details.dart';
import 'package:nodes/features/dashboard/screen/dashboard_view_all_dynamic_screen.dart';
import 'package:nodes/utilities/constants/key_strings.dart';

const Map<String, dynamic> persistentRoutesSettings = {
  KeyString.homeScreen: [
    DashboardScreen.routeName,
    DashboardViewAllDynamicScreen.routeName,
    DashboardSingleItemDetailsScreen.routeName,
  ],
  KeyString.profileScreen: [],
  KeyString.communityScreen: [
    NodeSpacesScreen.routeName,
    SpaceDetailsScreen.routeName,
  ],
  KeyString.forBusinessScreen: [],
  KeyString.subscriptionScreen: [],
};

// Widget getDynamicScreen<T>(NavController m, {T? args}) {
Widget getDynamicScreen(NavController m) {
  debugPrint("Here is the current sub page: ${m.currentPageListStackItem}");
  return switch (m.currentPageListStackItem) {
    // Write a function to return these...Or manually list em all...
    DashboardScreen.routeName => const DashboardScreen(),
    DashboardViewAllDynamicScreen.routeName =>
      const DashboardViewAllDynamicScreen(),
    DashboardSingleItemDetailsScreen.routeName =>
      //  DashboardSingleItemDetailsScreen(s: args as String,),
      const DashboardSingleItemDetailsScreen(),
    NodeSpacesScreen.routeName => const NodeSpacesScreen(),
    SpaceDetailsScreen.routeName => const SpaceDetailsScreen(),

    // Serves as default value
    _ => const DashboardScreen()
  };
}
