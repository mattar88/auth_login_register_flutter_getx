import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../config/config_api.dart';
import 'api_service.dart';

class AuthApiService extends ApiService {
  static String signUpUrl = '/jsonapi/user/register';
  static String signInUrl = '/oauth/token';

  Future<Response?> signUp(Map<String, dynamic> data) async {
    try {
      var body = {
        'name': data['username'],
        'mail': data['email'],
      };
      if (ConfigAPI.signupWithPassword) {
        body['pass'] = {
          'pass1': data['password'],
          'pass2': data['confirmPassword']
        };
      }
      return post(signUpUrl, body);
    } catch (e) {
      // printLog(e);
      printError(info: e.toString());
      rethrow;
    }
  }

//   void signOut() async {
//     await _authenticationService.signOut();
//     _authenticationStateStream.value = UnAuthenticated();
//   }
}
