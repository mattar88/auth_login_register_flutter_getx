import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:oauth2/oauth2.dart';

import '../config/config_api.dart';
import '../controllers/auth_controller.dart';
import '../routes/app_pages.dart';

import 'package:get/get.dart';

import 'auth_api_service.dart';
import 'oauth_client_service.dart';

class ApiService extends GetConnect {
  bool isLoginRequest(request) {
    return (ConfigAPI.basrUrl + AuthApiService.signInUrl ==
        request.url.toString());
  }

//
//  Return true when the token refreshed successfully or the user is authenticated
//
  static Future<bool> checkAuthAndRefresh() async {
    AuthController authController = Get.find();
    OAuthClientService oAuthClientService = Get.find();

    if (!authController.isAuthenticated()) {
      Credentials? oauthCredentails = await authController.refreshToken();
      if (oauthCredentails == null) {
        authController.signOut();
        Get.offAllNamed(Routes.LOGIN);
        return false;
      }
      return true;
    }
    return true;
  }

  int retry = 0;
  @override
  void onInit() {
    httpClient.baseUrl = ConfigAPI.basrUrl;
    httpClient.timeout = const Duration(seconds: 30);
    httpClient.maxAuthRetries = retry = 3;
    httpClient.followRedirects = true;

//addAuthenticator only is called after
//a request (get/post/put/delete) that returns HTTP status code 401
    httpClient.addAuthenticator<dynamic>((request) async {
      retry--;
      log('addAuthenticator ${request.url.toString()}');

      AuthController authController = Get.find();
      OAuthClientService oAuthClientService = Get.find();
      Credentials? oauthCredentails = oAuthClientService.credentials;
      try {
        if (oauthCredentails != null && oauthCredentails.canRefresh) {
          oauthCredentails = await authController.refreshToken();

          if (oauthCredentails!.accessToken.isNotEmpty) {
            request.headers['Authorization'] =
                'Bearer ${oauthCredentails.accessToken}';
          } else {
            if (retry == 0) {
              retry = httpClient.maxAuthRetries;

              if (!isLoginRequest(request)) {
                // log('check is isLoginRequest(request): ${isLoginRequest(request)}');
                Get.offAllNamed(Routes.LOGIN);
              }
            }
          }
        } else {
          if (retry == 0) {
            retry = httpClient.maxAuthRetries;
            if (!isLoginRequest(request)) {
              Get.offAllNamed(Routes.LOGIN, arguments: {
                'message': {
                  'status': 'warning',
                  'status_text': 'session_expired',
                  'body': 'Session expired please log in again.!'
                }
              });
            }
          }
        }
      } catch (err, _) {
        printError(info: err.toString());

        Get.offAllNamed(Routes.LOGIN, arguments: {
          'message': {
            'status': 'warning',
            'status_text': 'session_expired',
            'body':
                'Session expired Or invalid refresh token, please log in again.!'
          }
        });
      }

      return request;
    });

    httpClient.addResponseModifier((request, response) {
      log('call addREsponseModifier ${response.statusCode}, ${request.url}');

      if (response.statusCode == 403) {
        return Response(request: request, statusCode: 401);
      }
      return response;
    });

    httpClient.addRequestModifier<dynamic>((request) async {
      // log('call addRequestModifier , ${request.headers}');
      AuthController authController = Get.find();

      if (authController.isAuthenticated()) {
        // log('Add Request Modifier is authenticated');
        request.headers['Authorization'] =
            'Bearer ${authController.tokenCredentials()!.accessToken}';
      } else {
        log('addRequestModifier else condition ');
        request.headers['Authorization'] = 'Basic ' +
            base64Encode(utf8.encode(OAuthClientService.clientId +
                ':' +
                OAuthClientService.clientSecret));
      }
      return request;
    });
  }
}
