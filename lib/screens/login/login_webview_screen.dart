import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../controllers/login/login_webview_controller.dart';

class LoginWebviewScreen extends GetView<LoginWebviewController> {
  const LoginWebviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        WebViewWidget(controller: controller.webViewController),
        Obx(() => ((controller.loadingPercentage.value! < 100)
            ? LinearProgressIndicator(
                value: controller.loadingPercentage / 100.0,
              )
            : Stack())),
        Obx(() => (controller.loading.value!)
            ? const Center(child: CircularProgressIndicator())
            : Stack())
      ],
    )));
  }
}
