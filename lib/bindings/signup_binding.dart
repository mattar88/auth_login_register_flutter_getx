import 'package:get/get.dart';

import '../controllers/signup_controller.dart';
import '../services/auth_api_service.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(
        () => SignupController(Get.find<AuthApiService>()));
  }
}
