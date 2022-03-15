import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:general_directorate_grains/controllers/auth_controller.dart';
import 'package:general_directorate_grains/routes/app_routes.dart';
import 'package:general_directorate_grains/services/cache_service.dart';
import 'package:general_directorate_grains/widgets/Loading_overlay.dart';
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
    var response = await ovens();
    log('load oven success');
    // if done, change status to success
    // change(null, status: RxStatus.success());
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
        change(response.body, status: RxStatus.success());
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
