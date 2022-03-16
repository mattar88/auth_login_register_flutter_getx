import 'package:auth_login_register_flutter_getx/controllers/home_controller.dart';
import 'package:auth_login_register_flutter_getx/services/home_api_service.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeApiService>(() => HomeApiService());
    Get.lazyPut<HomeController>(
        () => HomeController(Get.find<HomeApiService>()));
  }
}
