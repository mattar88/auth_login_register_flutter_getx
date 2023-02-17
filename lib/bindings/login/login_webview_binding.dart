import '../../controllers/login/login_webview_controller.dart';
import '../../services/oauth_client_service.dart';

import '../../controllers/login/login_controller.dart';
import '../../services/auth_api_service.dart';
import '../../services/cache_service.dart';
import 'package:get/get.dart';

class LoginWebviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginWebviewController>(
        () => LoginWebviewController(Get.find<OAuthClientService>()));
  }
}
