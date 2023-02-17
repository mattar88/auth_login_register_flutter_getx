import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../routes/app_pages.dart';
import '../../services/oauth_client_service.dart';

class LoginWebviewController extends GetxController {
  final OAuthClientService _OAuthClientService;
  LoginWebviewController(this._OAuthClientService);
  String? initialUrl;
  Rxn<bool> loading = Rxn<bool>(true);
  Rxn<int> loadingPercentage = Rxn<int>(0);

  @override
  void onInit() {
    initialUrl =
        Uri.decodeFull(_OAuthClientService.getAuthorizationUrl().toString());
    super.onInit();
  }

  FutureOr<NavigationDecision> navigationDelegate(
      NavigationRequest navReq) async {
    log('Navvv');
    if (navReq.url.startsWith(OAuthClientService.redirectUrl.toString())) {
      var responseUrl = Uri.parse(navReq.url);

      if (responseUrl.queryParameters['code'] != null) {
        var client =
            await _OAuthClientService.handleAuthorizationResponse(responseUrl);

        await _OAuthClientService.saveCredentails(client!.credentials);

        Get.offAllNamed(Routes.HOME);

        return NavigationDecision.prevent;
      }
    }
    return NavigationDecision.navigate;
  }

  void onPageStarted(String url) {
    loading.value = true;
    loadingPercentage.value = 0;
  }

  void onProgress(int progress) {
    loading.value = true;
    loadingPercentage.value = progress;
  }

  void onPageFinished(String url) {
    loading.value = false;
    loadingPercentage.value = 100;
  }
}
