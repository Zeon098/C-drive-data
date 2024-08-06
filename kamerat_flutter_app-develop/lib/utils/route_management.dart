import 'package:get/get.dart';

import 'package:kamerat_flutter_app/pages/forget_password/reset_password_successful.dart';
import 'package:kamerat_flutter_app/pages/profile/settings/account_security.dart';
import 'package:kamerat_flutter_app/controllers/tutorial_details.controller.dart';
import 'package:kamerat_flutter_app/pages/forget_password/verify_reset_code.dart';
import 'package:kamerat_flutter_app/pages/profile/settings/change_password.dart';
import 'package:kamerat_flutter_app/pages/forget_password/forget_password.dart';
import 'package:kamerat_flutter_app/pages/forget_password/reset_password.dart';
import 'package:kamerat_flutter_app/pages/profile/settings/email_change.dart';
import 'package:kamerat_flutter_app/controllers/service_down.controller.dart';
import 'package:kamerat_flutter_app/pages/auth/verification_successful.dart';
import 'package:kamerat_flutter_app/pages/on_boarding/buy_subscription.dart';
import 'package:kamerat_flutter_app/pages/on_boarding/profile_picture.dart';
import 'package:kamerat_flutter_app/pages/profile/settings/personal.dart';
import 'package:kamerat_flutter_app/controllers/index.controller.dart';
import 'package:kamerat_flutter_app/pages/on_boarding/gender.dart';
import 'package:kamerat_flutter_app/pages/courses/catalogue.dart';
import 'package:kamerat_flutter_app/pages/auth/verify_email.dart';
import 'package:kamerat_flutter_app/pages/tutorial_details.dart';
import 'package:kamerat_flutter_app/pages/session_expired.dart';
import 'package:kamerat_flutter_app/pages/signin_required.dart';
import 'package:kamerat_flutter_app/pages/courses/details.dart';
import 'package:kamerat_flutter_app/pages/notifications.dart';
import 'package:kamerat_flutter_app/pages/zoomed_image.dart';
import 'package:kamerat_flutter_app/pages/likes_screen.dart';
import 'package:kamerat_flutter_app/pages/service_down.dart';
import 'package:kamerat_flutter_app/pages/auth/signup.dart';
import 'package:kamerat_flutter_app/pages/auth/signin.dart';
import 'package:kamerat_flutter_app/pages/no_internet.dart';
import 'package:kamerat_flutter_app/pages/index.dart';
import 'package:kamerat_flutter_app/splash.dart';

import 'package:kamerat_flutter_app/controllers/personal_settings.controller.dart';
import 'package:kamerat_flutter_app/controllers/verify_reset_code.controller.dart';
import 'package:kamerat_flutter_app/controllers/course_catalogue.controller.dart';
import 'package:kamerat_flutter_app/controllers/profile_picture.controller.dart';
import 'package:kamerat_flutter_app/controllers/forget_password.controller.dart';
import 'package:kamerat_flutter_app/controllers/change_password.controller.dart';
import 'package:kamerat_flutter_app/controllers/reset_passwrod.controller.dart';
import 'package:kamerat_flutter_app/controllers/course_details.controller.dart';
import 'package:kamerat_flutter_app/controllers/verify_email.controller.dart';
import 'package:kamerat_flutter_app/controllers/email_change.controller.dart';
import 'package:kamerat_flutter_app/controllers/signup.controller.dart';
import 'package:kamerat_flutter_app/controllers/signin.controller.dart';
import 'package:kamerat_flutter_app/controllers/gender.controller.dart';
import 'package:kamerat_flutter_app/controllers/splash.controller.dart';
import 'package:kamerat_flutter_app/controllers/likes.controller.dart';

import 'package:kamerat_flutter_app/middlewares/auth.middleware.dart';

import 'package:kamerat_flutter_app/utils/constants.dart';

class RouteManagement {
  static List<GetPage> getPage() {
    return [
      GetPage(
        name: kSplashRoute,
        page: () => const Splash(),
        binding: BindingsBuilder(() => SplashController()),
      ),
      GetPage(
        name: kNoInternetRoute,
        page: () => const NoInternet(),
      ),
      GetPage(
        name: kServiceDownRoute,
        page: () => const ServiceDown(),
        binding: BindingsBuilder(() {
          Get.lazyPut<ServiceDownController>(() => ServiceDownController());
        }),
      ),
      GetPage(
        name: kMainRoute,
        page: () => const MainScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<IndexController>(() => IndexController());
        }),
      ),
      GetPage(
        name: kLikesRoute,
        page: () => const LikesScreen(),
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: kZoomedImageRoute,
        page: () => const ZoomedImage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<ZoomedImageController>(() => ZoomedImageController());
        }),
      ),
      GetPage(
        name: kCourseCatalogueRoute,
        page: () => const CourseCatalogue(),
        binding: BindingsBuilder(() {
          Get.lazyPut<CourseCatalogueController>(
              () => CourseCatalogueController());
        }),
      ),
      GetPage(
        name: kCourseDetailsRoute,
        page: () => const CourseDetails(),
        binding: BindingsBuilder(() {
          Get.lazyPut<CourseDetailsController>(() => CourseDetailsController());
        }),
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: kTutorialDetailsRoute,
        page: () => const TutorialDetails(),
        binding: BindingsBuilder(() {
          Get.lazyPut<TutorialDetailsController>(
              () => TutorialDetailsController());
        }),
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: kSignUpRoute,
        page: () => const SignUp(),
        binding: BindingsBuilder(() {
          Get.lazyPut<SignUpController>(() => SignUpController());
        }),
      ),
      GetPage(
          name: kVerifyEmailRoute,
          page: () => const VerifyEmail(),
          binding: BindingsBuilder(() {
            Get.lazyPut<VerifyEmailController>(() => VerifyEmailController());
          })),
      GetPage(
        name: kSignInRoute,
        page: () => const SignIn(),
        binding: BindingsBuilder(() {
          Get.lazyPut<SignInController>(() => SignInController());
        }),
      ),
      GetPage(
        name: kVerificationSuccessfulRoute,
        page: () => const VerificationSuccessful(),
      ),
      GetPage(
        name: kOnBoardingGenderRoute,
        page: () => const Gender(),
        binding: BindingsBuilder(() {
          Get.lazyPut<GenderController>(() => GenderController());
        }),
      ),
      GetPage(
        name: kOnBoardingProfilePictureRoute,
        page: () => const ProfilePicture(),
        binding: BindingsBuilder(() {
          Get.lazyPut<ProfilePictureController>(
              () => ProfilePictureController());
        }),
      ),
      GetPage(
        name: kForgetPasswordRoute,
        page: () => const ForgetPassword(),
        binding: BindingsBuilder(() {
          Get.lazyPut<ForgetPasswordController>(
              () => ForgetPasswordController());
        }),
      ),
      GetPage(
        name: kVerifyResetCodeRoute,
        page: () => const VerifyResetCode(),
        binding: BindingsBuilder(() {
          Get.lazyPut<VerifyResetCodeController>(
              () => VerifyResetCodeController());
        }),
      ),
      GetPage(
        name: kResetPasswordRoute,
        page: () => const ResetPassword(),
        binding: BindingsBuilder(() {
          Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
        }),
      ),
      GetPage(
        name: kResetPasswordSuccessfulRoute,
        page: () => const ResetPasswordSuccessful(),
      ),
      GetPage(
        name: kPersonalSettingsRoute,
        page: () => const PersonalSettings(),
        binding: BindingsBuilder(() {
          Get.lazyPut<PersonalSettingsController>(
            () => PersonalSettingsController(),
          );
        }),
      ),
      GetPage(name: kSessionExpiredRoute, page: () => const SessionExpired()),
      GetPage(name: kSignInRequiredRoute, page: () => const SignInRequired()),
      GetPage(name: kAccountSecurityRoute, page: () => const AccountSecurity()),
      GetPage(
        name: kEmailChangeRoute,
        page: () => const EmailChange(),
        binding: BindingsBuilder(() {
          Get.lazyPut<EmailChangeController>(() => EmailChangeController());
        }),
      ),
      GetPage(
        name: kPasswordChangeRoute,
        page: () => const PasswordChange(),
        binding: BindingsBuilder(() {
          Get.lazyPut<PasswordChangeController>(
              () => PasswordChangeController());
        }),
      ),
      GetPage(name: kNotificationsRoute, page: () => const Notifications()),
      GetPage(
        name: kSubscriptionRoute,
        page: () => const BuySubscription(),
        arguments: const {
          "isForOnBoarding": true,
        },
      ),
    ];
  }
}
