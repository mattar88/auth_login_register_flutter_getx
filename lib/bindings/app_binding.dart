import 'package:general_directorate_grains/services/connectivity_service.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    injectService();
  }

  void injectService() {
    Get.put(ConnectivityService());
  }
}
