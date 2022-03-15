import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService extends GetxService {
  @override
  void onInit() async {
    super.onInit();
    var hasConnection = await InternetConnectionChecker().hasConnection;
    if (!hasConnection) {
      showDialog();
    }

    var listener = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          hideDialogIfOpen();
          print('Data connection is available.');
          break;
        case InternetConnectionStatus.disconnected:
          if (Get.isDialogOpen != true) {
            showDialog();
          }
          print('You are disconnected from the internet.');
          break;
      }
    });

    // close listener after 30 seconds, so the program doesn't run forever
    Future.delayed(Duration(seconds: 30), () {
      listener.cancel();
    });
  }

  void hideDialogIfOpen() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  void showDialog() {
    Get.dialog(
      CupertinoAlertDialog(
        title: Row(children: [
          Icon(Icons.signal_wifi_off_outlined),
          Container(
              margin: EdgeInsets.only(left: 5),
              child: Text('You are currently offline')),
        ]),
        content: Text(
            'Please turn on network connection to continue using this app'),
      ),
      barrierDismissible: true,
    );
  }
}
