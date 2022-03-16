import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:auth_login_register_flutter_getx/services/cache_service.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  final CacheService _cacheService = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (_cacheService.sessionIsEmpty()) {
      return RouteSettings(name: Routes.LOGIN);
    }
  }
}
