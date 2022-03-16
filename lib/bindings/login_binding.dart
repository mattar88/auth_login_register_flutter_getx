import 'package:auth_login_register_flutter_getx/controllers/login_controller.dart';
import 'package:auth_login_register_flutter_getx/services/auth_api_service.dart';
import 'package:auth_login_register_flutter_getx/services/cache_service.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() =>
        LoginController(Get.find<AuthApiService>(), Get.find<CacheService>()));
  }
}
