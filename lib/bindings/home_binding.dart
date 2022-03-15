import 'package:general_directorate_grains/controllers/home_controller.dart';
import 'package:general_directorate_grains/services/home_api_service.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeApiService>(() => HomeApiService());
    Get.lazyPut<HomeController>(
        () => HomeController(Get.find<HomeApiService>()));
  }
}
