import 'dart:io';

import 'package:get/get.dart';
import 'package:oauth2/oauth2.dart';
import 'package:path_provider/path_provider.dart';

import '../mixins/helper_mixin.dart';
import 'oauth_client_service.dart';

class CacheService extends GetxService with HelperMixin {
  late File credentialsFile;
  var directory;
  Credentials? credentialsOAuth;

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
    credentialsOAuth = credentials;
    await credentialsFile.writeAsString(credentialsOAuth!.toJson());
    return true;
  }

  Future<Credentials?> loadToken() async {
    OAuthClientService _OAuthClientService = Get.find();
    return credentialsOAuth = await _OAuthClientService.loadCredentails();
  }

  Future<void> removeToken() async {
    await credentialsFile.writeAsString('');
  }
}

enum CacheManagerKey { TOKEN }
