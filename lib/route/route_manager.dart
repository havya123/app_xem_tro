import 'package:app_xem_tro/screen/error_screen/error_screen.dart';
import 'package:app_xem_tro/screen/login_screen/login_screen.dart';
import 'package:app_xem_tro/screen/signup_screen/signup_screen.dart';
import 'package:app_xem_tro/screen/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

class RouteManager {
  static List<GetPage> routeManager = [
    GetPage(name: "/", page: () => const SplashScreen()),
    GetPage(name: "/loginRoute", page: () => const LoginScreen()),
    GetPage(name: "/signupRoute", page: () => const SignupScreen()),
    GetPage(name: "/notFound", page: () => const ErrorScreen()),
  ];

  static GetPage notFound =
      GetPage(name: "/notFound", page: () => const ErrorScreen());
}
