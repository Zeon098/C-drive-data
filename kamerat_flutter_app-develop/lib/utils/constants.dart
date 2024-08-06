import 'package:flutter_dotenv/flutter_dotenv.dart';

const String kAppName = "Kamerat";

// routes
const String kSplashRoute = "/splash";
const String kNoInternetRoute = "/no-internet";
const String kServiceDownRoute = "/service-down";
const String kMainRoute = "/";
const String kLikesRoute = "/likes";
const String kZoomedImageRoute = "/zoomed-image:image";
const String kCourseCatalogueRoute = "/courses";
const String kCourseDetailsRoute = "/courses/:courseId";
const String kTutorialDetailsRoute = "/tutorials/:tutorial";
const String kSignUpRoute = "/signup";
const String kSignInRoute = "/signin";
const String kForgetPasswordRoute = "/forget-password";
const String kVerifyResetCodeRoute = "/verify-reset-code";
const String kResetPasswordRoute = "/reset-password";
const String kResetPasswordSuccessfulRoute = "/reset-password-successful";
const String kVerifyEmailRoute = "/verify-email";
const String kVerificationSuccessfulRoute = "/verification-successful";
const String kOnBoardingGenderRoute = "/onboarding/gender";
const String kOnBoardingProfilePictureRoute = "/onboarding/profile-picture";
const String kSubscriptionRoute = "/onboarding/subscription";
const String kPersonalSettingsRoute = "/settings/personal";
const String kAccountSecurityRoute = "/settings/account-security";
const String kEmailChangeRoute = "/settings/email-change";
const String kPasswordChangeRoute = "/settings/password-change";
const String kNotificationsSettingsRoute = "/settings/notifications";
const String kSessionExpiredRoute = "/session-expired";
const String kSignInRequiredRoute = "/signin-required";
const String kNotificationsRoute = "/notifications";

// Error Messages
const String kNoInternetMsg = "No internet connection";
const String kPoorInternetConnectionMsg = "Poor internet connection";
const String kSomethingWentWrongMsg = "Something went wrong";
const String kRequestTimeoutMsg = "Request timeout";

// HTTP Status Codes
const int kSuccessCode = 200;
const int kCreatedCode = 201;
const int kBadRequestCode = 400;
const int kUnauthorizedCode = 401;
const int kForbiddenCode = 403;
const int kNotFoundCode = 404;
const int kRequestTimeoutCode = 408;
const int kInternalServerErrorCode = 500;
const int kUnknownErrorCode = 0;

// enums
enum GENDER { male, female, other }

extension GenderExtension on GENDER {
  String get value {
    switch (this) {
      case GENDER.male:
        return "Male";
      case GENDER.female:
        return "Female";
      case GENDER.other:
        return "Other";
      default:
        return "Other";
    }
  }
}

enum COURSEPROGRESS { inprogress, completed }

extension CourseProgressExtension on COURSEPROGRESS {
  String get value {
    switch (this) {
      case COURSEPROGRESS.inprogress:
        return "inProgress";
      case COURSEPROGRESS.completed:
        return "completed";
      default:
        return "";
    }
  }
}

// Constants
const kTotalSplashDuration = 2400;
const kCourseNotificationType = "course";
const kSubscriptionNotificationType = "subscription";

// Subscription ID
String kSubscriptionID =
    dotenv.env['COURSES_SUBSCRIPTION_ID'] ?? 'test_subscription';

// IOS subscriptions URL
String kIOSSubscriptionUrl = 'https://apps.apple.com/account/subscriptions';
