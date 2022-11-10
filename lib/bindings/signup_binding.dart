import 'package:auth_login_register_flutter_getx/services/oauth_client_service.dart';

import '../controllers/signup_controller.dart';
import '../services/auth_api_service.dart';
import '../services/cache_service.dart';
import 'package:get/get.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(() => SignupController(
        Get.find<AuthApiService>(), Get.find<OAuthClientService>()));
  }
}
