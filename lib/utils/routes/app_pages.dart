import 'package:get/get.dart';

import '../../app/modules/Pre_onlineTest_instruction/bindings/Pre_onlineTest_instruction_binding.dart';
import '../../app/modules/Pre_onlineTest_instruction/views/Pre_onlineTest_instruction_view.dart';
import '../../app/modules/Pre_onlineTest_instruction2/bindings/Pre_onlineTest_instruction2_binding.dart';
import '../../app/modules/Pre_onlineTest_instruction2/views/Pre_onlineTest_instruction_view.dart';
import '../../app/modules/Question_details/bindings/question_details_binding.dart';
import '../../app/modules/Question_details/views/question_details_view.dart';
import '../../app/modules/Test/bindings/Test_binding.dart';
import '../../app/modules/Test/views/Test_view.dart';
import '../../app/modules/TestList/bindings/TestList_binding.dart';
import '../../app/modules/TestList/views/TestList.dart';
import '../../app/modules/onlineTestSeries/bindings/online_test_series_binding.dart';
import '../../app/modules/onlineTestSeries/views/online_test_series_view.dart';
import '../../views/about_screen/about_us_binding.dart';
import '../../views/about_screen/about_us_view.dart';
import '../../views/dashboard/bindings/dashboard_binding.dart';
import '../../views/dashboard/views/dashboard_view.dart';
import '../../views/detailed_coaching_screen/detailed_coaching_view.dart';
import '../../views/detailed_coaching_screen/detailed_coching_binding.dart';
import '../../views/detailed_course_screen/detailed_course_binding.dart';
import '../../views/detailed_course_screen/detailed_course_view.dart';
import '../../views/main/screens/AppSplashScreen.dart';
import '../../views/main/screens/splash_binding.dart';
import '../../views/sign_up_screen/signup_binding.dart';
import '../../views/sign_up_screen/signup_view.dart';
import '../../views/specific_book_details_screen/specific_book_details_binding.dart';
import '../../views/specific_book_details_screen/specific_books_views.dart';
import '../../views/subject_books/subject_wise_view.dart';
import '../../views/subject_books/subject_wise_view_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: signup_binding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const AppSplashScreen(),
      binding: splash_binding(),
    ),
    GetPage(
      name: _Paths.ABOUT_US,
      page: () => AboutAppSimpleBlueRoute(),
      binding: about_us_binding(),
    ),
    GetPage(
      name: _Paths.COCHING_DETAILS,
      page: () => DetailedCoachingView(),
      binding: detailed_coching_binding(),
    ),
    GetPage(
      name: _Paths.SPECIFIC_BOOK_VIEW,
      page: () => specific_books_views(),
      binding: specific_book_details_binding(),
    ),
    GetPage(
      name: _Paths.SUBJECT_WISE_VIEW,
      page: () => SubjectWiseView(),
      binding: subject_wise_view_binding(),
    ),
    GetPage(
      name: _Paths.COURSE_DETAILS,
      page: () => TabsSimpleLightRoute(),
      binding: detailed_course_binding(),
    ),
    GetPage(
      name: _Paths.DESHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.ONLINE_TEST_SERIES,
      page: () => const OnlineTestSeriesView(),
      binding: OnlineTestSeriesBinding(),
    ),
    GetPage(
      name: _Paths.TEST_LIST,
      page: () => const TestListView(),
      binding: TestList_Binding(),
    ),
    GetPage(
      name: _Paths.PRE_ONLINETEST_INSTRUCTION,
      page: () => Pre_onlineTest_instruction_view(),
      binding: Pre_onlineTest_instruction_Binding(),
    ),
    GetPage(
      name: _Paths.PRE_ONLINETEST_INSTRUCTION2,
      page: () => Pre_onlineTest_instruction2_view(),
      binding: Pre_onlineTest_instruction2_binding(),
    ),
    GetPage(
      name: _Paths.TEST,
      page: () => Test_view(),
      binding: TestBinding(),
    ),
    GetPage(
      name: _Paths.QUESTION_DETAILS,
      page: () => const QuestionDetailsView(),
      binding: QuestionDetailsBinding(),
    ),
  ];
}
