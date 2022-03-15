import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:general_directorate_grains/services/cache_service.dart';
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
