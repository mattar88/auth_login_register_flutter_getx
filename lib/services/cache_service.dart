import 'dart:developer';
import 'dart:io';

import 'package:oauth2/oauth2.dart';

import '../config/config_api.dart';
import '../mixins/helper_mixin.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

import 'oauth_client_service.dart';

class CacheService extends GetxService with HelperMixin {
  late File credentialsFile;
  var directory;
  Credentials? credentialsOAuth;

  @override
  onInit() async {
    // OAuthClientService _OAuthClientService = Get.find();
    // credentialsOAuth = _OAuthClientService.client.credentials;
    super.onInit();
  }

  initCredentials() async {
    directory = await getApplicationDocumentsDirectory();
    credentialsFile = File('${directory.path}/credentials.json');
    await loadToken();
  }

  void logOut() {
    removeToken();
  }

  void login(Credentials credentials) async {
    credentialsOAuth = credentials;
    //Token is cached
    await saveAuthCrednetials(credentials);
  }

  Future<bool> saveAuthCrednetials(Credentials credentials) async {
    // final box = GetStorage();
    // log('saveToken --- ${token.toJson()}');
    // await box.write(CacheManagerKey.TOKEN.toString(), token.toJson());
    credentialsOAuth = credentials;
    await credentialsFile.writeAsString(credentialsOAuth!.toJson());
    return true;
  }

  Future<Credentials?> loadToken() async {
    OAuthClientService _OAuthClientService = Get.find();
    return credentialsOAuth = await _OAuthClientService.loadCredentails();
    // if (exists) {
    //   var credentials =
    //       oauth2.Credentials.fromJson(await credentialsFile.readAsString());
    // }
    // // final box = GetStorage();
    // // var jsonToken = box.read(CacheManagerKey.TOKEN.toString());
    // // log('-----------------${jsonToken['expires_in']}----------');
    // return jsonToken != null ? TokenModel.fromJson(jsonToken) : null;
  }

  Future<void> removeToken() async {
    await credentialsFile.writeAsString('');
    // final box = GetStorage();
    // await box.remove(CacheManagerKey.TOKEN.toString());
  }
}

enum CacheManagerKey { TOKEN }
