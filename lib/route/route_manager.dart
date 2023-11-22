import 'package:app_xem_tro/route/routes.dart';
import 'package:app_xem_tro/screen/admin_screen/admin_account_screen.dart';
import 'package:app_xem_tro/screen/admin_screen/admin_approve_screen.dart';
import 'package:app_xem_tro/screen/admin_screen/admin_booking_screen.dart';
import 'package:app_xem_tro/screen/admin_screen/admin_screen.dart';
import 'package:app_xem_tro/screen/chat_screen/chat_screen.dart';
import 'package:app_xem_tro/screen/detail_screen/detail_screen.dart';
import 'package:app_xem_tro/screen/detail_screen/over_view_screen.dart';
import 'package:app_xem_tro/screen/error_screen/error_screen.dart';
import 'package:app_xem_tro/screen/forget_password_screen/forget_password_screen.dart';
import 'package:app_xem_tro/screen/forget_password_screen/reset_password.dart';
import 'package:app_xem_tro/screen/house_registration/house_registration.dart';
import 'package:app_xem_tro/screen/house_registration/room_registration.dart';
import 'package:app_xem_tro/screen/listhouse_screen/listhouse_screen.dart';
import 'package:app_xem_tro/screen/listroom_screen/listroom_screen.dart';
import 'package:app_xem_tro/screen/login_screen/login_screen.dart';
import 'package:app_xem_tro/screen/navigationlisthouse_screen/navigationlisthouse.dart';
import 'package:app_xem_tro/screen/navigationroom_screen/navigationroom_screen.dart';
import 'package:app_xem_tro/screen/profile_screen/detail_profile_screen.dart';
import 'package:app_xem_tro/screen/profile_screen/profie_screen.dart';
import 'package:app_xem_tro/screen/review_screen/review_screen.dart';
import 'package:app_xem_tro/screen/root_screen/root_screen.dart';
import 'package:app_xem_tro/screen/search_screen/search_screen.dart';
import 'package:app_xem_tro/screen/signup_screen/second_signup.dart';
import 'package:app_xem_tro/screen/navigation_screen.dart/navigation_screen.dart';
import 'package:app_xem_tro/screen/save_screen/save_screen.dart';
import 'package:app_xem_tro/screen/signup_screen/signup_screen.dart';
import 'package:app_xem_tro/screen/admin_screen/admin_login_screen.dart';
import 'package:app_xem_tro/screen/splash_admin/splash_admin_screen.dart';
import 'package:app_xem_tro/screen/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

import '../screen/home_screen/home_screen.dart';

class RouteManager {
  static List<GetPage> routeManager = [
    GetPage(
      name: "/",
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: "/loginRoute",
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: "/signupRoute",
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: "/notFoundRoute",
      page: () => const ErrorScreen(),
    ),
    GetPage(
      name: "/forgetRoute",
      page: () => const ForgetPasswordScreen(),
    ),
    GetPage(
      name: "/homeRoute",
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: "/resetRoute",
      page: () => const ResetPassword(),
    ),
    GetPage(name: "/secondSignupRoute", page: () => const SecondSignup()),
    GetPage(
      name: "/navigationRoute",
      page: () => const NavigationScreen(),
    ),
    GetPage(
      name: "/saveRoute",
      page: () => const SaveScreen(),
    ),
    GetPage(
      name: "/chatRoute",
      page: () => const ChatScreen(),
    ),
    GetPage(
      name: "/profileRoute",
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: "/searchRoute",
      page: () => const SearchScreen(),
    ),
    GetPage(
      name: "/splashAdminRoute",
      page: () => const SplashScreenAdmin(),
    ),
    GetPage(
      name: "/adminLoginRoute",
      page: () => const AdminLogin(),
    ),
    GetPage(
      name: "/detailProfileRoute",
      page: () => const DetailProfileScreen(),
    ),
    GetPage(
      name: "/adminRoute",
      page: () => const AdminScreen(),
    ),
    GetPage(
      name: "/adminAccountRoute",
      page: () => const AdminAccountScreen(),
    ),
    GetPage(
      name: "/adminBookingRoute",
      page: () => const AdminBookingScreen(),
    ),
    GetPage(
      name: "/adminApproveRoute",
      page: () => const AdminApproveScreen(),
    ),
    GetPage(
      name: "/detailRoute",
      page: () => const DetailScreen(),
    ),
    GetPage(
      name: "/overviewRoute",
      page: () => const OverViewScreen(),
    ),
    GetPage(
      name: "/reviewRoute",
      page: () => const ReviewScreen(),
    ),
    GetPage(
      name: "/houseRegistrationRoute",
      page: () => const HouseRegistration(),
    ),
    GetPage(
      name: "/roomRegistrationRoute",
      page: () => const RoomRegistration(),
    ),
    GetPage(
      name: "/listHouseRoute",
      page: () => const ListHouse(),
    ),
    GetPage(
      name: "/navigationListHouseRoute",
      page: () => const NavigationListHouseScreen(),
    ),
    GetPage(
      name: "/listRoomRoute",
      page: () => const ListRoom(),
    ),
    GetPage(
      name: "/navigationListRoomRoute",
      page: () => const NavigationListRoomScreen(),
    ),
    GetPage(name: Routes.rootRoute, page: () => const RootScreen())
  ];

  static GetPage notFound = GetPage(
    name: "/notFoundRoute",
    page: () => const ErrorScreen(),
  );
}
