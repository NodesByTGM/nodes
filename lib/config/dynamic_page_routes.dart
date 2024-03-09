import 'package:flutter/material.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/community/screens/nodes_community_screen.dart';
import 'package:nodes/features/community/screens/nodes_spaces_screen.dart';
import 'package:nodes/features/community/screens/space_details_screen.dart';
import 'package:nodes/features/dashboard/screen/dashboard_screen.dart';
import 'package:nodes/features/dashboard/screen/dashboard_single_item_details.dart';
import 'package:nodes/features/dashboard/screen/dashboard_view_all_dynamic_screen.dart';
import 'package:nodes/features/profile/screens/business/business_profile_screen.dart';
import 'package:nodes/features/profile/screens/business/edit_business_profile_screen.dart';
import 'package:nodes/features/profile/screens/individual/edit_individual_profile_screen.dart';
import 'package:nodes/features/profile/screens/individual/individual_profile_screen.dart';
import 'package:nodes/features/profile/screens/profile_wrapper.dart';
import 'package:nodes/features/profile/screens/talent/edit_talent_profile_screen.dart';
import 'package:nodes/features/profile/screens/talent/talent_profile_screen.dart';
import 'package:nodes/utilities/constants/key_strings.dart';

const Map<String, dynamic> persistentRoutesSettings = {
  // Home Screen
  KeyString.homeScreen: [
    DashboardScreen.routeName,
    DashboardViewAllDynamicScreen.routeName,
    DashboardSingleItemDetailsScreen.routeName,
  ],
  // Profile Screen
  KeyString.profileScreen: [
    ProfileWrapper.routeName,
    IndividualProfileScreen.routeName,
    EditIndividualProfileScreen.routeName,
    TalentProfileScreen.routeName,
    EditTalentProfileScreen.routeName,
    BusinessProfileScreen.routeName,
    EditBusinessProfileScreen.routeName,
  ],
  // Community Screen
  KeyString.communityScreen: [
    NodeSpacesScreen.routeName,
    SpaceDetailsScreen.routeName,
    NodeCommunityScreen.routeName,
  ],
  // Business Screen
  KeyString.forBusinessScreen: [],
  // Subscription Screen
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
    NodeCommunityScreen.routeName => const NodeCommunityScreen(),

    // Profiles
    ProfileWrapper.routeName => const ProfileWrapper(),
    IndividualProfileScreen.routeName => const IndividualProfileScreen(),
    EditIndividualProfileScreen.routeName => const EditIndividualProfileScreen(),
    TalentProfileScreen.routeName => const TalentProfileScreen(),
    EditTalentProfileScreen.routeName => const EditTalentProfileScreen(),
    BusinessProfileScreen.routeName => const BusinessProfileScreen(),
    EditBusinessProfileScreen.routeName => const EditBusinessProfileScreen(),

    // Serves as default value
    _ => const DashboardScreen()
  };
}
