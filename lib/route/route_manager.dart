import 'package:app_xem_tro/screen/chat_screen/chat_screen.dart';
import 'package:app_xem_tro/screen/error_screen/error_screen.dart';
import 'package:app_xem_tro/screen/forget_password_screen/forget_password_screen.dart';
import 'package:app_xem_tro/screen/home_screen/home_screen.dart';
import 'package:app_xem_tro/screen/login_screen/login_screen.dart';
import 'package:app_xem_tro/screen/navigation_screen.dart/navigation_screen.dart';
import 'package:app_xem_tro/screen/profile_screen/profile_screen.dart';
import 'package:app_xem_tro/screen/save_screen/save_screen.dart';
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
      name: "/notFound",
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
      GetPage(name: "/notFound", page: () => const ErrorScreen());
}
