import 'package:flutter/material.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/community/screens/nodes_community_screen.dart';
import 'package:nodes/features/community/screens/nodes_spaces_screen.dart';
import 'package:nodes/features/community/screens/space_details_screen.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_job_details_screen.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_screen.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_view_all_jobs.dart';
import 'package:nodes/features/dashboard/screen/dashboard_wrapper.dart';
import 'package:nodes/features/dashboard/screen/individual/individual_dashboard_screen.dart';
import 'package:nodes/features/dashboard/screen/individual/individual_dashboard_single_item_details.dart';
import 'package:nodes/features/dashboard/screen/individual/individual_dashboard_view_all_dynamic_screen.dart';
import 'package:nodes/features/dashboard/screen/talent/talent_dashboard_screen.dart';
import 'package:nodes/features/dashboard/screen/talent/talent_dashboard_view_all_jobs.dart';
import 'package:nodes/features/grid_tools/screens/grid_tools_screen.dart';
import 'package:nodes/features/profile/screens/business/business_profile_screen.dart';
import 'package:nodes/features/profile/screens/business/edit_business_profile_screen.dart';
import 'package:nodes/features/profile/screens/individual/edit_individual_profile_screen.dart';
import 'package:nodes/features/profile/screens/individual/individual_profile_screen.dart';
import 'package:nodes/features/profile/screens/profile_wrapper.dart';
import 'package:nodes/features/profile/screens/talent/edit_talent_profile_screen.dart';
import 'package:nodes/features/profile/screens/talent/talent_profile_screen.dart';
import 'package:nodes/features/settings/screens/account_settings_screen.dart';
import 'package:nodes/utilities/constants/key_strings.dart';

const Map<String, dynamic> persistentRoutesSettings = {
  // Home Screen
  KeyString.homeScreen: [
    DashboardWrapper.routeName,
    IndividualDashboardScreen.routeName,
    IndividualDashboardViewAllDynamicScreen.routeName,
    IndividualDashboardSingleItemDetailsScreen.routeName,
    TalentDashboardScreen.routeName,
    BusinessDashboardScreen.routeName,
    BusinessJobCenterScreen.routeName,
    BusinessJobDetailsScreen.routeName,
  ],
  // Profile Screen
  KeyString.profileScreen: [
    ProfileWrapper.routeName,
    IndividualProfileScreen.routeName,
    EditIndividualProfileScreen.routeName,
    TalentProfileScreen.routeName,
    TalentJobCenterScreen.routeName,
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
  // Account Settings Screen
  KeyString.accountSettingsScreen: [
    AccountSettingsScreen.routeName,
  ],
  // Business Screen
  KeyString.forBusinessScreen: [],
  // Subscription Screen
  KeyString.subscriptionScreen: [],
  // GridTools Screen
  KeyString.gridToolScreen: [
    GridToolsScreen.routeName,
  ],
  // UpgradeToPro Screen
  KeyString.upgradeToProScreen: [],
};

// Widget getDynamicScreen<T>(NavController m, {T? args}) {
Widget getDynamicScreen(NavController m) {
  debugPrint("Here is the current sub page: ${m.currentPageListStackItem}");
  return switch (m.currentPageListStackItem) {
    // Write a function to return these...Or manually list em all...
    DashboardWrapper.routeName => const DashboardWrapper(),
    // Individual Dashboard
    IndividualDashboardScreen.routeName => const IndividualDashboardScreen(),
    IndividualDashboardViewAllDynamicScreen.routeName =>
      const IndividualDashboardViewAllDynamicScreen(),
    IndividualDashboardSingleItemDetailsScreen.routeName =>
      //  IndividualDashboardSingleItemDetailsScreen(s: args as String,),
      const IndividualDashboardSingleItemDetailsScreen(),
    // Talent Dashboard
    TalentDashboardScreen.routeName => const TalentDashboardScreen(),
    // Business Dashboard
    BusinessDashboardScreen.routeName => const BusinessDashboardScreen(),
    BusinessJobCenterScreen.routeName => const BusinessJobCenterScreen(),
    BusinessJobDetailsScreen.routeName => const BusinessJobDetailsScreen(),

    // Spaces and Community
    NodeSpacesScreen.routeName => const NodeSpacesScreen(),
    SpaceDetailsScreen.routeName => const SpaceDetailsScreen(),
    NodeCommunityScreen.routeName => const NodeCommunityScreen(),

    // Profiles
    ProfileWrapper.routeName => const ProfileWrapper(),
    IndividualProfileScreen.routeName => const IndividualProfileScreen(),
    EditIndividualProfileScreen.routeName =>
      const EditIndividualProfileScreen(),
    TalentProfileScreen.routeName => const TalentProfileScreen(),
    TalentJobCenterScreen.routeName => const TalentJobCenterScreen(),
    EditTalentProfileScreen.routeName => const EditTalentProfileScreen(),
    BusinessProfileScreen.routeName => const BusinessProfileScreen(),
    EditBusinessProfileScreen.routeName => const EditBusinessProfileScreen(),

    // Account Settings
    AccountSettingsScreen.routeName => const AccountSettingsScreen(),

    // Business

    // Grid Tools
    GridToolsScreen.routeName => const GridToolsScreen(),

    // Upgrade to Pro

    // Subscription

    // Serves as default value
    _ => const IndividualDashboardScreen()
  };
}
