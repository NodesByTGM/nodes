import 'package:flutter/material.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/community/screens/nodes_community_screen.dart';
import 'package:nodes/features/community/screens/nodes_spaces_screen.dart';
import 'package:nodes/features/community/screens/space_details_screen.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_job_details_screen.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_event_details_screen.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_screen.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_view_all_created_events.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_view_all_created_jobs.dart';
import 'package:nodes/features/dashboard/screen/business/business_pre_dashboard_screen.dart';
import 'package:nodes/features/dashboard/screen/dashboard_wrapper.dart';
import 'package:nodes/features/dashboard/screen/individual/individual_dashboard_screen.dart';
import 'package:nodes/features/dashboard/screen/individual/individual_dashboard_single_item_details.dart';
import 'package:nodes/features/dashboard/screen/individual/individual_dashboard_view_all_dynamic_screen.dart';
import 'package:nodes/features/dashboard/screen/talent/talent_dashboard_screen.dart';
import 'package:nodes/features/dashboard/screen/talent/talent_dashboard_view_all_applied_jobs.dart';
import 'package:nodes/features/dashboard/screen/talent/talent_dashboard_view_all_jobs.dart';
import 'package:nodes/features/dashboard/screen/trending_screen.dart';
import 'package:nodes/features/grid_tools/screens/grid_tools_screen.dart';
import 'package:nodes/features/profile/screens/business/business_profile_screen.dart';
import 'package:nodes/features/profile/screens/business/edit_business_profile_screen.dart';
import 'package:nodes/features/profile/screens/individual/edit_individual_profile_screen.dart';
import 'package:nodes/features/profile/screens/individual/individual_profile_screen.dart';
import 'package:nodes/features/profile/screens/profile_guest_wrapper.dart';
import 'package:nodes/features/profile/screens/profile_wrapper.dart';
import 'package:nodes/features/profile/screens/profiles_seen_as_guest/business_guest_profile.dart';
import 'package:nodes/features/profile/screens/profiles_seen_as_guest/individual_guest_profile.dart';
import 'package:nodes/features/profile/screens/profiles_seen_as_guest/talent_guest_profile.dart';
import 'package:nodes/features/profile/screens/talent/edit_talent_profile_screen.dart';
import 'package:nodes/features/profile/screens/talent/talent_profile_screen.dart';
import 'package:nodes/features/saves/screens/saved_items_screen.dart';
import 'package:nodes/features/settings/screens/account_settings_screen.dart';
import 'package:nodes/features/subscriptions/screen/proceed_with_payment_screen.dart';
import 'package:nodes/features/subscriptions/screen/subscription_screen.dart';
import 'package:nodes/utilities/constants/key_strings.dart';

const Map<String, dynamic> persistentRoutesSettings = {
  // Home Screen
  KeyString.homeScreen: [
    DashboardWrapper.routeName,
    IndividualDashboardScreen.routeName,
    IndividualDashboardViewAllDynamicScreen.routeName,
    IndividualDashboardSingleItemDetailsScreen.routeName,
    TalentDashboardScreen.routeName,
    TalentAppliedJobCenterScreen.routeName,
    TalentJobCenterScreen.routeName,
    // BusinessDashboardScreen.routeName, // Until I figure out what's going on, this will be placed in the "For Business"
  ],
  // Profile Screen
  KeyString.profileScreen: [
    ProfileWrapper.routeName,
    IndividualProfileScreen.routeName,
    EditIndividualProfileScreen.routeName,
    TalentProfileScreen.routeName,
    EditTalentProfileScreen.routeName,
    // Guest Mode
    ProfileGuestWrapper.routeName,
    IndividualGuestProfileScreen.routeName,
    TalentGuestProfileScreen.routeName,
    BusinessGuestProfileScreen.routeName,
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
  KeyString.forBusinessScreen: [
    BusinessPreDashbaordScreen.routeName,
    BusinessCreatedJobCenterScreen.routeName,
    BusinessJobDetailsScreen.routeName,
    BusinessCreatedEventCenterScreen.routeName,
    BusinessEventDetailsScreen.routeName,
    BusinessDashboardScreen.routeName,
    BusinessProfileScreen.routeName,
    EditBusinessProfileScreen.routeName,
  ],
  KeyString.businessDashboardScreen: [
    BusinessEventDetailsScreen.routeName,
    BusinessDashboardScreen.routeName,
  ],

  KeyString.businessProfileScreen: [
    BusinessProfileScreen.routeName,
    EditBusinessProfileScreen.routeName,
  ],

  // Subscription Screen
  KeyString.subscriptionScreen: [
    SubscriptionScreen.routeName,
    ProceedWithPayment.routeName,
  ],

  // GridTools Screen
  KeyString.gridToolScreen: [
    GridToolsScreen.routeName,
  ],
  // UpgradeToPro Screen
  KeyString.upgradeToProScreen: [],

  // Saved Items Screen
  KeyString.savesScreen: [
    SavedItemScreen.routeName,
  ],

  // Trending Screen
  KeyString.trendingScreen: [
    TrendingDashboardScreen.routeName,
  ],
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
    BusinessPreDashbaordScreen.routeName => const BusinessPreDashbaordScreen(),
    BusinessDashboardScreen.routeName => const BusinessDashboardScreen(),
    BusinessCreatedJobCenterScreen.routeName =>
      const BusinessCreatedJobCenterScreen(),
    BusinessJobDetailsScreen.routeName => const BusinessJobDetailsScreen(),
    BusinessCreatedEventCenterScreen.routeName =>
      const BusinessCreatedEventCenterScreen(),
    BusinessEventDetailsScreen.routeName => const BusinessEventDetailsScreen(),

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
    TalentAppliedJobCenterScreen.routeName =>
      const TalentAppliedJobCenterScreen(),
    TalentJobCenterScreen.routeName => const TalentJobCenterScreen(),
    EditTalentProfileScreen.routeName => const EditTalentProfileScreen(),
    BusinessProfileScreen.routeName => const BusinessProfileScreen(),
    EditBusinessProfileScreen.routeName => const EditBusinessProfileScreen(),
    // >> Guest Mode
    ProfileGuestWrapper.routeName => const ProfileGuestWrapper(),
    IndividualGuestProfileScreen.routeName =>
      const IndividualGuestProfileScreen(),
    TalentGuestProfileScreen.routeName => const TalentGuestProfileScreen(),
    BusinessGuestProfileScreen.routeName => const BusinessGuestProfileScreen(),

    // Account Settings
    AccountSettingsScreen.routeName => const AccountSettingsScreen(),

    // Business

    // Grid Tools
    GridToolsScreen.routeName => const GridToolsScreen(),

    // Upgrade to Pro

    // Subscription
    SubscriptionScreen.routeName => const SubscriptionScreen(),
    ProceedWithPayment.routeName => const ProceedWithPayment(),

    // Saved Items
    SavedItemScreen.routeName => const SavedItemScreen(),

    // Talent Screen
    TrendingDashboardScreen.routeName => const TrendingDashboardScreen(),

    // Serves as default value
    _ => const IndividualDashboardScreen()
  };
}
