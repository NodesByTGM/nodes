// ignore_for_file: constant_identifier_names

enum DrawerRouteTitle {
  Profile,
  Home,
  Community,
  ForBusiness,
  BusinessProfile,
  BusinessDashboard,
  Subscription,
  UpgradeToPro,
  Trending,
  SavedJobs,
  AccountSettings,
}

enum HorizontalSlidingCardDataSource {
  Empty,
  TopMovies,
  HiddenGems,
  Flashbacks,
  Community,
  CollaborationSpotlights,
  Birthdays,
  MoreLikeThis,
  Recommended,
}

enum FilterSort { Filter, Sort }

enum SocialMediaTypes {
  Instagram,
  Twitter,
  Linkedin,
}
 
enum AccountType {
  Default, //0
  Talent, // 1
  Business, // 2
}

enum AccountRules {
  USER,
  ADMIN,
}

enum JobTypes {
  FULL_TIME,
  PART_TIME,
  CONTRACT,
}

enum PostTypes {
  Community,
  Space,
}

enum MembersTypes {
  Member,
  Admin,
}

enum PaymentStatus {
  Successful,
  Cancelled,
}

enum SubscriptionPlanKeys {
  pro,
  pro_annual, // use '-' instead of '_'
  business,
  business_annual,
}

enum NotificationType {
  All, Mentioned, Unread,
}