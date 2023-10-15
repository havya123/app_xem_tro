import 'package:app_xem_tro/screen/chat_screen/chat_screen.dart';
import 'package:app_xem_tro/screen/error_screen/error_screen.dart';
import 'package:app_xem_tro/screen/forget_password_screen/forget_password_screen.dart';
import 'package:app_xem_tro/screen/forget_password_screen/reset_password.dart';
import 'package:app_xem_tro/screen/login_screen/login_screen.dart';
import 'package:app_xem_tro/screen/signup_screen/second_signup.dart';
import 'package:app_xem_tro/screen/navigation_screen.dart/navigation_screen.dart';
import 'package:app_xem_tro/screen/profile_screen/profile_screen.dart';
import 'package:app_xem_tro/screen/save_screen/save_screen.dart';
import 'package:app_xem_tro/screen/signup_screen/signup_screen.dart';
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
  ];

  static GetPage notFound =
      GetPage(name: "/notFoundRoute", page: () => const ErrorScreen());
}
