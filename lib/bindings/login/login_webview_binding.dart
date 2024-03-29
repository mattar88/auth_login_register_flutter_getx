import 'package:get/get.dart';

import '../../controllers/login/login_webview_controller.dart';
import '../../services/auth_api_service.dart';

class LoginWebviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginWebviewController>(
        () => LoginWebviewController(Get.find<AuthApiService>()));
  }
}
