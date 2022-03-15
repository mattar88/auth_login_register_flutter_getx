import 'package:get/get.dart';
import 'api_service.dart';

class HomeApiService extends ApiService {
  static String homeUrl = '/api/ovens';
  Future<Response<dynamic>> loadHome() async {
    return get(homeUrl);
  }
}
