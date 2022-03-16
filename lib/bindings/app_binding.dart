import 'package:auth_login_register_flutter_getx/services/connectivity_service.dart';
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
