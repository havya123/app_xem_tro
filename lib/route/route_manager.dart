import 'package:app_xem_tro/screen/admin_screen/admin_account_screen.dart';
import 'package:app_xem_tro/screen/admin_screen/admin_approve_screen.dart';
import 'package:app_xem_tro/screen/admin_screen/admin_booking_screen.dart';
import 'package:app_xem_tro/screen/admin_screen/admin_screen.dart';
import 'package:app_xem_tro/screen/chat_screen/list_chat_screen.dart';
import 'package:app_xem_tro/screen/error_screen/error_screen.dart';
import 'package:app_xem_tro/screen/forget_password_screen/forget_password_screen.dart';
import 'package:app_xem_tro/screen/home_screen/home_screen.dart';
import 'package:app_xem_tro/screen/login_screen/login_screen.dart';
import 'package:app_xem_tro/screen/profile_screen/detail_profile_screen.dart';
import 'package:app_xem_tro/screen/profile_screen/profie_screen.dart';
import 'package:app_xem_tro/screen/signup_screen/signup_screen.dart';
import 'package:app_xem_tro/screen/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

class RouteManager {
  static List<GetPage> routeManager = [
    GetPage(
      name: "/",
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: "/loginRoute",
      page: () => const LoginScreen(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: "/signupRoute",
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: "/forgetRoute",
      page: () => const ForgetPasswordScreen(),
    ),
    GetPage(
      name: "/homeRoute",
      page: () => const HomeScreen(),
    ),

    // PROFILE
    GetPage(
      name: "/profileRoute",
      page: () => const Profile(),
    ),
    GetPage(
      name: "/detailprofileRoute",
      page: () => const DetailProfileScreen(),
    ),
    // ADMIN
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
    // CHAT
    GetPage(
      name: "/listchatRoute",
      page: () => const ListChatScreen(),
    ),

    //ERROR
    GetPage(
      name: "/notFound",
      page: () => const ErrorScreen(),
    ),
  ];

  static GetPage notFound = GetPage(
    name: "/notFound",
    page: () => const ErrorScreen(),
  );
}
