import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';
import '../services/auth_api_service.dart';

class AuthMiddleware extends GetMiddleware {
  final AuthApiService _authenticationService = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (_authenticationService.sessionIsEmpty()) {
      return RouteSettings(name: Routes.LOGIN);
    }
  }
}
