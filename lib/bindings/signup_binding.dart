import 'package:general_directorate_grains/controllers/signup_controller.dart';
import 'package:general_directorate_grains/services/auth_api_service.dart';
import 'package:general_directorate_grains/services/cache_service.dart';
import 'package:get/get.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(() =>
        SignupController(Get.find<AuthApiService>(), Get.find<CacheService>()));
  }
}
