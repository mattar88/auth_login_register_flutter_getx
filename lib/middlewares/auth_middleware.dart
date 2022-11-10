import 'dart:developer';

import 'package:flutter/cupertino.dart';
import '../services/cache_service.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../services/oauth_client_service.dart';

class AuthMiddleware extends GetMiddleware {
  final OAuthClientService _OAuthClientService = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (_OAuthClientService.sessionIsEmpty()) {
      return RouteSettings(name: Routes.LOGIN);
    }
  }
}
