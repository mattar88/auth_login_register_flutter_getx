import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auth_login_register_flutter_getx/controllers/auth_controller.dart';
import 'package:auth_login_register_flutter_getx/services/cache_service.dart';
import 'package:auth_login_register_flutter_getx/widgets/Loading_overlay.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../services/auth_api_service.dart';

class LoginController extends AuthController {
  final GlobalKey<FormState> loginFormKey =
      GlobalKey<FormState>(debugLabel: '__loginFormKey__');
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginController(
      AuthApiService authenticationService, CacheService cacheServices)
      : super(authenticationService, cacheServices);

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String? validator(String? value) {
    log('validatoooor');

    if (value != null && value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  Future<void> login() async {
    log('${emailController.text}, ${passwordController.text}');
    if (loginFormKey.currentState!.validate()) {
      try {
        await signIn(emailController.text, passwordController.text);
      } catch (err, _) {
        // message = 'There is an issue with the app during request the data, '
        //         'please contact admin for fixing the issues ' +

        passwordController.clear();
        rethrow;
      }
    } else {
      throw Exception('An error occurred, invalid inputs value');
    }
  }
}
