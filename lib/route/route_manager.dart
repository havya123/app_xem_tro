import 'package:app_xem_tro/route/routes.dart';
import 'package:app_xem_tro/screen/all_house_screen/all_house_screen.dart';
import 'package:app_xem_tro/screen/booking_screen/booking_screen.dart';
import 'package:app_xem_tro/screen/chat_screen/chat_screen.dart';
import 'package:app_xem_tro/screen/chat_screen/list_chat_screen.dart';
import 'package:app_xem_tro/screen/detail_screen/detail_screen.dart';
import 'package:app_xem_tro/screen/detail_screen/over_view_screen.dart';
import 'package:app_xem_tro/screen/error_screen/error_screen.dart';
import 'package:app_xem_tro/screen/forget_password_screen/forget_password_screen.dart';
import 'package:app_xem_tro/screen/forget_password_screen/reset_password.dart';
import 'package:app_xem_tro/screen/home_screen/home_screen.dart';
import 'package:app_xem_tro/screen/house_registration/house_registration.dart';
import 'package:app_xem_tro/screen/house_registration/room_registration.dart';
import 'package:app_xem_tro/screen/listhouse_screen/listhouse_nearby_screen.dart';
import 'package:app_xem_tro/screen/listhouse_screen/listhouse_screen.dart';
import 'package:app_xem_tro/screen/listroom_screen/listroom_screen.dart';
import 'package:app_xem_tro/screen/listroom_screen/listroom_user_screen.dart';
import 'package:app_xem_tro/screen/login_screen/login_screen.dart';
import 'package:app_xem_tro/screen/map_screen/fullmap_screen.dart';
import 'package:app_xem_tro/screen/navigation_screen.dart/navigation_screen.dart';
import 'package:app_xem_tro/screen/navigationlisthouse_screen/navigationlisthouse.dart';
import 'package:app_xem_tro/screen/navigationroom_screen/navigationroom_screen.dart';
import 'package:app_xem_tro/screen/profile_screen/detail_profile_screen.dart';
import 'package:app_xem_tro/screen/profile_screen/profie_screen.dart';
import 'package:app_xem_tro/screen/review_screen/review_screen.dart';
import 'package:app_xem_tro/screen/root_screen/root_screen.dart';
import 'package:app_xem_tro/screen/search_screen/search_screen.dart';
import 'package:app_xem_tro/screen/signup_screen/second_signup.dart';
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
      name: Routes.secondSignup,
      page: () => const SecondSignup(),
    ),

    GetPage(
      name: "/forgetRoute",
      page: () => const ForgetPasswordScreen(),
    ),
    GetPage(
      name: "/navigationRoute",
      page: () => const NavigationScreen(),
    ),
    GetPage(
      name: "/homeRoute",
      page: () => const HomeScreen(),
    ),

    // PROFILE
    GetPage(
      name: "/profileRoute",
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: Routes.detailProfileRoute,
      page: () => const DetailProfileScreen(),
    ),
    GetPage(
      name: Routes.resetRoute,
      page: () => const ResetPassword(),
    ),
    // ADMIN

    // CHAT
    GetPage(
      name: "/listchatRoute",
      page: () => const ListChatScreen(),
    ),

    //ERROR
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
      name: Routes.chatRoute,
      page: () => const ChatScreen(),
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
    GetPage(
      name: Routes.searchRoute,
      page: () => const SearchScreen(),
    ),
    GetPage(
      name: "/mapRoute",
      page: () => const FullMapScreen(),
    ),
    GetPage(
      name: Routes.rootRoute,
      page: () => const RootScreen(),
    ),
    GetPage(
      name: Routes.resetRoute,
      page: () => const ResetPassword(),
    ),
    GetPage(
      name: "/listRoomRouteUser",
      page: () => const ListRoomUserScreen(),
    ),
    GetPage(
      name: Routes.detailRoute,
      page: () => const DetailScreen(),
    ),
    GetPage(
      name: Routes.listHouseNearby,
      page: () => const ListHouseNearBy(),
    ),
    GetPage(
      name: Routes.bookingroute,
      page: () => const BookingScreen(),
    ),
    GetPage(
      name: Routes.allHouseRoute,
      page: () => const AllHouseScreen(),
    ),
  ];

  static GetPage notFound = GetPage(
    name: "/notFound",
    page: () => const ErrorScreen(),
  );
}
