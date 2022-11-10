import 'dart:convert';
import 'dart:developer';
import 'package:auth_login_register_flutter_getx/services/oauth_client_service.dart';
import 'package:oauth2/oauth2.dart';

import '../routes/app_routes.dart';
import '../services/cache_service.dart';
import 'package:get/get.dart';
import '../services/auth_api_service.dart';

//This controller doesn't have view page but used
// for some widget button like signout and other
class AuthController extends GetxController {
  final AuthApiService _authenticationService;
  final OAuthClientService _oAuthClientService;

  AuthController(this._authenticationService, this._oAuthClientService);

  Future<Credentials?> signIn(String email, String password) async {
    try {
      log('Enter Signin');
      return await _oAuthClientService.authGrantPassword(email, password);
      // log('is logged in : ${crednetials!.accessToken}');
    } catch (e) {
      // printLog(e);
      printError(info: e.toString());
      rethrow;
    }
  }

  Future<Response?> signUp(Map<String, dynamic> data) async {
    String error_m =
        'An error occurred while registering, please contact the administrator.';
    try {
      return await _authenticationService.signUp(data);

      // if (response.statusCode == 200) {
      //   log('enter signup');

      //   // tokenData = await signIn(data['email'], data['password']);
      // } else {
      //   // var message = response.body['error_description'];

      //   throw Exception(error_m);
      // }
    } catch (e) {
      // printLog(e);
      printError(info: e.toString());
      throw Exception(error_m);
    }
    // return tokenData;
  }

  Future<Credentials?> refreshToken() async {
    try {
      return _oAuthClientService.refreshToken();
    } catch (e) {
      printError(info: 'exception refreshToken 1:  ${e.toString()}');
      rethrow;
    }
  }

  Credentials? tokenCredentials() => _oAuthClientService.credentials;

  void signOut() async {
    _oAuthClientService.removeCredentails();
  }

  bool isAuthenticated() {
    return !_oAuthClientService.sessionIsExpired();
  }
}
