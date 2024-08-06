import 'package:flutter_dotenv/flutter_dotenv.dart';

String kBaseUrl = dotenv.env['BASE_URL'] ?? "http://localhost:3000";
String kBaseAssetsUrl =
    dotenv.env['BASE_ASSETS_URL'] ?? "http://localhost:3000";
String kregisterUserUrl = "$kBaseUrl/auth/sign-up";
String ksigninUrl = "$kBaseUrl/auth/login";
String kverifyEmailUrl = "$kBaseUrl/auth/verify-email";
String kResendVerificationCode = '$kBaseUrl/auth/resend-verify-email';
String kProfileUrl = "$kBaseUrl/auth/profile";
String kUploadProfilePictureUrl = "$kBaseUrl/auth/profile-image";
String kforgetPasswordUrl = "$kBaseUrl/auth/forget-password";
String kVerifyResetCodeUrl = "$kBaseUrl/auth/verify-reset-password-code";
String kResetPasswordUrl = "$kBaseUrl/auth/reset-password";
String kChangeEmailUrl = "$kBaseUrl/auth/change-email";
String kChangePasswordUrl = "$kBaseUrl/auth/change-password";
String kDeleteAccountUrl = "$kBaseUrl/user/delete-my-account";
String kMeUrl = "$kBaseUrl/auth/me";
String kRefreshTokenUrl = "$kBaseUrl/auth/resfresh-token";

String kPictureOfMonthUrl = "$kBaseUrl/picture-of-month/recent-months";
String kLikePictureUrl = "$kBaseUrl/picture-of-month/like";
String kUnlikePictureUrl = "$kBaseUrl/picture-of-month/unlike";
String kLikedPicturesUrl = "$kBaseUrl/picture-of-month/my-liked";

String kNewsFeedUrl = "$kBaseUrl/news-feed?active=true&pageSize=50";

String kCoursesUrl = "$kBaseUrl/course";
String kSearchUrl = "$kBaseUrl/course/course-season-tutorial";
String kCategoriesUrl = "$kBaseUrl/category/list";

String kCourseSubscriptionUrl = "$kBaseUrl/course/subscription";
String kCourseProgressUrl(id) {
  return "$kBaseUrl/course/$id/subscription";
}

String kVerifySubsscriptionStatus =
    '$kBaseUrl/in-app-purchase/verify/subscription/status';

String kCheckSubscriptionStatus =
    '$kBaseUrl/in-app-purchase/check-subscription';

String kRegisterFCMTokenUrl = '$kBaseUrl/user/register-push-notification';
