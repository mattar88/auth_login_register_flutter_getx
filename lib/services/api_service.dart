import 'dart:convert';
import 'dart:developer';

import 'package:auth_login_register_flutter_getx/config/config_api.dart';
import 'package:auth_login_register_flutter_getx/controllers/auth_controller.dart';
import 'package:auth_login_register_flutter_getx/models/token_model.dart';
import 'package:auth_login_register_flutter_getx/routes/app_routes.dart';

import 'package:get/get.dart';

import 'auth_api_service.dart';

class ApiService extends GetConnect {
  int retry = 0;

  @override
  void onInit() {
    httpClient.baseUrl = ConfigAPI.basrUrl;
    httpClient.timeout = const Duration(seconds: 15);
    httpClient.maxAuthRetries = retry = 3;
    httpClient.followRedirects = true;

//addAuthenticator only is called after
//a request (get/post/put/delete) that returns HTTP status code 401
    httpClient.addAuthenticator<dynamic>((request) async {
      retry--;
      log('addAuthenticator ${request.url.toString()}');

      AuthController authController = Get.find();
      TokenModel? newToken;
      try {
        newToken = await authController.refreshToken();
        if (newToken != null) {
          request.headers['Authorization'] = 'Bearer ${newToken.accessToken}';
        } else {
          if (retry == 0) {
            retry = httpClient.maxAuthRetries;

            if (!isLoginRequest(request)) {
              Get.offAllNamed(Routes.LOGIN);
            }
          }
        }
      } catch (err, _) {
        printError(info: err.toString());
      }

      return request;
    });

    httpClient.addRequestModifier<dynamic>((request) async {
      log('addRequestModifier ${request.url.toString()}');

      AuthController authController = Get.find();
      if (authController.isAuthenticated()) {
        request.headers['Authorization'] =
            'Bearer ${authController.token()!.accessToken}';
      } else {
        request.headers['Authorization'] = 'Basic ' +
            base64Encode(
                utf8.encode(ConfigAPI.clientId + ':' + ConfigAPI.clientSecret));
      }
      return request;
    });
  }

  bool isLoginRequest(request) {
    return (ConfigAPI.basrUrl + AuthApiService.signInUrl ==
        request.url.toString());
  }
}
