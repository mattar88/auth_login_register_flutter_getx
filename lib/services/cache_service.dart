import 'dart:developer';

import 'package:general_directorate_grains/config/config_api.dart';
import 'package:general_directorate_grains/mixins/helper_mixin.dart';
import 'package:general_directorate_grains/models/token_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CacheService extends GetxService with HelperMixin {
  TokenModel? token;

  @override
  onInit() {
    token = loadToken();
    super.onInit();
  }

  void logOut() {
    token = null;
    removeToken();
  }

  void login(TokenModel token) async {
    this.token = token;
    //Token is cached
    await saveToken(token);
  }

  Future<bool> saveToken(TokenModel token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token.toJson());
    return true;
  }

  TokenModel? loadToken() {
    final box = GetStorage();
    var jsonToken = box.read(CacheManagerKey.TOKEN.toString());
    // log('-----------------${jsonToken['expires_in']}----------');
    return jsonToken != null ? TokenModel.fromJson(jsonToken) : null;
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
  }

  bool sessionIsEmpty() {
    if (token == null) return true;
    return false;
  }

  bool sessionIsExpired() {
    if (token == null) return true;

    int currentTimestamp = HelperMixin.getTimestamp();
    bool isExceeded = (token!.timestamp +
            token!.expiresIn -
            ConfigAPI.sessionTimeoutThreshold -
            currentTimestamp) <=
        0;

    // log('${DateTime.now().microsecondsSinceEpoch / 1000}');
    printInfo(
        info:
            'Expired in: ${token != null ? (token!.timestamp + token!.expiresIn - currentTimestamp) / 60 : 0} mins -- isExceeded: ${isExceeded.toString()}');
    return isExceeded;
  }
}

enum CacheManagerKey { TOKEN }
