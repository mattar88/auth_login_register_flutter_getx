import 'dart:convert';
import 'dart:developer';
import 'package:auth_login_register_flutter_getx/models/token_model.dart';
import 'package:auth_login_register_flutter_getx/routes/app_routes.dart';
import 'package:auth_login_register_flutter_getx/services/cache_service.dart';
import 'package:get/get.dart';
import '../services/auth_api_service.dart';

//This controller doesn't have view page but used
// for some widget button like signout and other
class AuthController extends GetxController {
  final AuthApiService _authenticationService;
  final CacheService _cacheServices;

  AuthController(this._authenticationService, this._cacheServices);

  Future<TokenModel?> signIn(String email, String password) async {
    TokenModel? tokenData;
    try {
      log('Enter Signin');
      var response = await _authenticationService.signIn(email, password);
      log('is logged in : ${response.statusCode}');

      if (response.statusCode == 200) {
        log('${response.body}');
        tokenData = TokenModel.fromJson(response.body);
        _cacheServices.login(tokenData);
      } else {
        var message = response.body['error_description'];
        log('message---{message}');
        throw Exception(message ?? 'An error occurred, please try again.');
      }
    } catch (e) {
      // printLog(e);
      printError(info: e.toString());
      rethrow;
    }
    return tokenData;
  }

  Future<TokenModel?> signUp(Map<String, dynamic> data) async {
    TokenModel? tokenData;
    String error_m =
        'An error occurred while registering, please contact the administrator.';
    try {
      var response = await _authenticationService.signUp(data);
      log('is signup : ${response.toString()}');
      if (response.statusCode == 200) {
        log('enter signup');

        tokenData = await signIn(data['email'], data['password']);
      } else {
        // var message = response.body['error_description'];

        throw Exception(error_m);
      }
    } catch (e) {
      // printLog(e);
      printError(info: e.toString());
      throw Exception(error_m);
    }
    return tokenData;
  }

  Future<TokenModel?> refreshToken() async {
    if (_cacheServices.token == null) return null;
    TokenModel? tokenData;
    try {
      var response = await _authenticationService
          .refreshToken(_cacheServices.token!.refreshToken);
      if (response.statusCode == 200) {
        log('refreshToken():  ${response.body}');
        tokenData = TokenModel.fromJson(response.body);
        _cacheServices.login(tokenData);
      } else {
        var message = response.body['error_description'];
        throw Exception(message ?? 'An error occurred, please try again.');
      }
    } catch (e) {
      printError(info: 'exception refreshToken 1:  ${e.toString()}');
      rethrow;
    }
    return tokenData;
  }

  TokenModel? token() => _cacheServices.token;

  void signOut() async {
    _cacheServices.logOut();
  }

  bool isAuthenticated() {
    return !_cacheServices.sessionIsExpired();
  }
}
