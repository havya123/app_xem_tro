import 'package:app_xem_tro/screen/error_screen/error_screen.dart';
import 'package:app_xem_tro/screen/forget_password_screen/forget_password_screen.dart';
<<<<<<< Updated upstream
<<<<<<< Updated upstream
=======
import 'package:app_xem_tro/screen/forget_password_screen/reset_password.dart';
=======
>>>>>>> Stashed changes
import 'package:app_xem_tro/screen/home_screen/home_screen.dart';
>>>>>>> Stashed changes
import 'package:app_xem_tro/screen/login_screen/login_screen.dart';
import 'package:app_xem_tro/screen/signup_screen/second_signup.dart';
import 'package:app_xem_tro/screen/signup_screen/signup_screen.dart';
import 'package:app_xem_tro/screen/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

class RouteManager {
  static List<GetPage> routeManager = [
<<<<<<< Updated upstream
    GetPage(name: "/", page: () => const SplashScreen()),
    GetPage(name: "/loginRoute", page: () => const LoginScreen()),
    GetPage(name: "/signupRoute", page: () => const SignupScreen()),
    GetPage(name: "/secondsignup", page: () => const SecondSignup()),
    GetPage(name: "/notFound", page: () => const ErrorScreen()),
    GetPage(name: "/forget", page: () => const ForgetPasswordScreen()),
=======
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
<<<<<<< Updated upstream
    ),
    GetPage(
      name: "/resetRoute",
      page: () => const ResetPassword(),
    ),
>>>>>>> Stashed changes
=======
    )
>>>>>>> Stashed changes
  ];

  static GetPage notFound =
      GetPage(name: "/notFound", page: () => const ErrorScreen());
}
