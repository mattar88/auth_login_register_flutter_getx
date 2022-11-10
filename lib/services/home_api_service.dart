import 'package:get/get.dart';
import 'api_service.dart';

class HomeApiService extends ApiService {
  static String homeUrl =
      '/jsonapi/node/article/b207ea24-cadf-4210-b5b6-665113bb7a48?resourceVersion=id%3A1';
  Future<Response<dynamic>> loadHome() async {
    return get(homeUrl);
  }
}
