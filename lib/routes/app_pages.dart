import 'dart:developer';

import 'package:auth_login_register_flutter_getx/bindings/home_binding.dart';
import 'package:auth_login_register_flutter_getx/bindings/login_binding.dart';
import 'package:auth_login_register_flutter_getx/bindings/signup_binding.dart';
import 'package:auth_login_register_flutter_getx/middlewares/auth_middleware.dart';
import 'package:auth_login_register_flutter_getx/routes/app_routes.dart';
import 'package:auth_login_register_flutter_getx/screens/home/home_screen.dart';
import 'package:auth_login_register_flutter_getx/screens/signup/signup_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../screens/login/login_screen.dart';

// part 'routes.dart';
// This file will contain your array routing
class AppPages {
  static List<GetPage> pages = [
    GetPage(
        name: Routes.HOME,
        page: () => const HomeScreen(),
        binding: HomeBinding(),
        middlewares: [AuthMiddleware()],
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.LOGIN,
        page: () => const LoginScreen(),
        binding: LoginBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.SIGNUP,
        page: () => const SignupScreen(),
        binding: SignupBinding(),
        transition: Transition.noTransition),
  ];
}
