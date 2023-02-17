import 'dart:developer';

import 'package:flutter/material.dart';
import '../../config/config_api.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';
import '../../mixins/helper_mixin.dart';
import '../../routes/app_pages.dart';
import 'package:get/get.dart';

import '../../services/oauth_client_service.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  String getSessionTime() {
    try {
      int currentTimestamp = HelperMixin.getTimestamp();
      OAuthClientService oAuthClientService = Get.find();

      var credentials = oAuthClientService.credentials;
      return 'Expired in: ${credentials != null ? (credentials.expiration!.millisecondsSinceEpoch / 1000 - ConfigAPI.sessionTimeoutThreshold - currentTimestamp) / 60 : 0} mins';
    } catch (err) {
      return 'An error occurred when computing Session time';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28),
        ),
      ),
      body: controller.obx(
        (state) => Center(
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('This is the home page'),
              Text(getSessionTime()),
              ElevatedButton(
                onPressed: () {
                  Get.find<AuthController>().signOut();
                  Get.offAllNamed(Routes.LOGIN);
                },
                child: Text("Signout", style: TextStyle(color: Colors.white)),
              ),
            ],
          )),
        ),

        // here you can put your custom loading indicator, but
        // by default would be Center(child:CircularProgressIndicator())
        onLoading: CircularProgressIndicator(),
        onEmpty: Column(
          children: [
            const Text('No Data found'),
            ElevatedButton(
                onPressed: () {
                  Get.find<AuthController>().signOut();
                  Get.offAllNamed(Routes.LOGIN);
                },
                child: const Text("Signout",
                    style: TextStyle(color: Colors.white))),
          ],
        ),

        // here also you can set your own error widget, but by
        // default will be an Center(child:Text(error))
        onError: (error) => Text(''),
      ),
    );
  }
}
