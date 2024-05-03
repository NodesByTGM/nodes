class Constants {
  static const appName = "Nodes";
  static const continueText = "Continue";
  static const cancel = "Cancel";
  static const ok = "Ok";
  static const emptyFieldError = "Field can't be empty";
  static const email = "Email";
  static const emailError = "Email is required";
  static const emailInvalid = "Enter a valid email";
  static const password = "Password";
  static const passwordError = "Password is weak";
  static const passwordLenError = "Password length must be 6 or more";
  static const confirmPassword = "Confirm Password";
  static const passwordMatchError = "Password does not match!";
  static const monthError = "Please choose a month";
  static const dayError = "Please choose a day";
  static const naira = "₦";
  static const accountNotVerified =
      "Oops!! Your account hasn't been verified yet.";
  static const updateYourProfileToProceed =
      "Please update your profile to proceed.";
  static const proSubDesc =
      "Elevate your profile and access additional features";
  static const businessSubDesc =
      "Access all features for talent and businesses";

  static const jobType = [
    'Full-time',
    'Part-time',
    'Contract',
  ];
  static const standardFeatures = [
    "Community Engagement",
    "Networking Opportunities",
    "Stay Informed on Creative Trends",
  ];
  static const proFeatures = [
    "Everything on the standard plan",
    "Enhanced Visibility",
    "Access to Premium Jobs",
    "Expanded Project Showcase",
    "Advanced Analytics and Insights",
    "Access to GridTools Discovery Pack (Free)",
  ];
  static const businessFeatures = [
    "Everything in Talent",
    "Premium Talent Pool Access",
    "Featured Job Listings",
    "Analytics and Performance Metrics",
    "Promotion and Marketing Opportunities",
    "Access to GridTools Discovery Pack (Free)",
  ];

  static const industry = [
    "Acting",
    "Performing",
    "Movie Production",
    "Directing",
    "Fashion Design",
    "Styling",
    "Photography",
    "Videography",
    "Culinary Arts",
    "Cooking",
    "Modeling",
    "Runway",
    "Writing",
    "Scripting",
    "Makeup Artistry",
    "Set Design",
    "Art Direction",
    "Music",
    "Sound Production",
  ];

  static const jobRoles = [
    "Art Curator",
    "Architect",
    "Graphic Designer",
    "Fashion Designer",
    "Film Producer",
    "Music Producer",
    "Actor",
    "Actress",
    "Content writer",
    "Visual Artist (Painter/Sculptor)",
    "Jjournalist",
    "Choreographer",
    "Chef",
    "Interior Decorator",
  ];

  static const skillsList = [...industry, ...jobRoles];

  static const monthList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  static List<String> get yearList {
    int currentYear = DateTime.now().year;
    int ageGap = currentYear - 18;
    List<String> yArr = [];
    for (int i = 0; i <= 300; i++) {
      yArr.add("${ageGap--}");
    }
    return yArr;
  }
}
