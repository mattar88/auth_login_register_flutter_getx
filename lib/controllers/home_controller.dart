import 'dart:developer';

import 'package:get/get.dart';
import 'package:oauth2/oauth2.dart';

import '../config/config_api.dart';
import '../mixins/helper_mixin.dart';
import '../services/auth_api_service.dart';

class HomeController extends GetxController {
  HomeController();
  late Rx<Credentials> credentails;
  RxString sessionTime = RxString('');
  @override
  void onInit() {
    sessionTime.value = getSessionTime();

    credentails = getcredentials().obs;

    super.onInit();
  }

  getSessionTime() {
    try {
      int currentTimestamp = HelperMixin.getTimestamp();

      AuthApiService authenticationService = Get.find();
      var credentials = authenticationService.credentials;
      return '${credentials != null ? (credentials.expiration!.millisecondsSinceEpoch / 1000 - ConfigAPI.sessionTimeoutThreshold - currentTimestamp) / 60 : 0} mins';
    } catch (err) {
      throw Exception('An error occurred when computing Session time');
    }
  }

  Credentials getcredentials() {
    AuthApiService authenticationService = Get.find();
    return authenticationService.credentials!;
  }
}
