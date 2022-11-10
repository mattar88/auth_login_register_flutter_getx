import 'dart:convert';
import 'dart:developer';

import 'package:auth_login_register_flutter_getx/services/oauth_client_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../routes/app_routes.dart';
import '../services/cache_service.dart';
import '../widgets/Loading_overlay.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../services/auth_api_service.dart';
import '../services/home_api_service.dart';

class HomeController extends GetxController with StateMixin {
  final HomeApiService _homeApiService;

  HomeController(this._homeApiService);

  @override
  onInit() async {
    change(null, status: RxStatus.loading());
    OAuthClientService oAuthClientService = Get.find();

    var response = await ovens();
    log('load oven success');
    // if done, change status to success
    change(null, status: RxStatus.success());
    super.onInit();
  }

  Future ovens() async {
    try {
      var response = await _homeApiService.loadHome();
      if (response.statusCode == 401) {
        // Get.toNamed(Routes.LOGIN);
      }
      if (response.statusCode == 200) {
        //return json.decode(response.body);
        change(response, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
      // var message = response.toString();
      //

      // log('${json.decode(response.body)}');
      // log('All ovens loaded successfully');
    } catch (err, _) {
      log('${err}');
      rethrow;
    }
  }

  getData() async {
    // make status to loading
    change(null, status: RxStatus.loading());
    log('loading oven success');
    // Code to get data
    await ovens();
    log('load oven success');
    // if done, change status to success
    change(null, status: RxStatus.success());
  }
}
