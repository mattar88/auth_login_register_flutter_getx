import 'package:general_directorate_grains/controllers/login_controller.dart';
import 'package:general_directorate_grains/services/auth_api_service.dart';
import 'package:general_directorate_grains/services/cache_service.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() =>
        LoginController(Get.find<AuthApiService>(), Get.find<CacheService>()));
  }
}
