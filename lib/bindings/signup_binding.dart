import 'package:auth_login_register_flutter_getx/controllers/signup_controller.dart';
import 'package:auth_login_register_flutter_getx/services/auth_api_service.dart';
import 'package:auth_login_register_flutter_getx/services/cache_service.dart';
import 'package:get/get.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(() =>
        SignupController(Get.find<AuthApiService>(), Get.find<CacheService>()));
  }
}
