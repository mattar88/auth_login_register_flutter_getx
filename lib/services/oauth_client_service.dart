import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import '../services/auth_api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:oauth2/oauth2.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../config/config_api.dart';
import '../mixins/helper_mixin.dart';
import 'oauth_client_service.dart';

class OAuthClientService extends GetxService {
// These URLs are endpoints that are provided by the authorization
// server. They're usually included in the server's documentation of its
// OAuth2 API.
  static String authorizationUrl = '/oauth/authorize';
  static String refreshTokenUrl = '/oauth/token';
// This is a URL on your application's server. The authorization server
// will redirect the resource owner here once they've authorized the
// client. The redirection will include the authorization code in the
// query parameters.
  static const String redirectUrl = ConfigAPI.basrUrl + '/';

  final authorizationEndpoint = Uri.parse(ConfigAPI.basrUrl + authorizationUrl);
  final tokenEndpoint = Uri.parse(ConfigAPI.basrUrl + refreshTokenUrl);

// The authorization server will issue each client a separate client
// identifier and secret, which allows the server to tell which client
// is accessing it. Some servers may also have an anonymous
// identifier/secret pair that any client may use.
//
// Note that clients whose source code or binary executable is readily
// available may not be able to make sure the client secret is kept a
// secret. This is fine; OAuth2 servers generally won't rely on knowing
// with certainty that a client is who it claims to be.
  static const String clientId = 'CLIENT_ID';
  static const String clientSecret = 'CLIENT_SECRET';

  /// A file in which the users credentials are stored persistently. If the server
  /// issues a refresh token allowing the client to refresh outdated credentials,
  /// these may be valid indefinitely, meaning the user never has to
  /// re-authenticate.
  late File _credentialsFile;
  var _directory;
  Credentials? credentials;
  late AuthorizationCodeGrant _grant;
  oauth2.Client? client;

  initCredentials() async {
    _directory = await getApplicationDocumentsDirectory();
    _credentialsFile = File('${_directory.path}/credentials.json');
    _grant = oauth2.AuthorizationCodeGrant(
        clientId, authorizationEndpoint, tokenEndpoint,
        secret: clientSecret);
    credentials = await loadCredentails();
  }

  getAuthorizationUrl() {
    // A URL on the authorization server (authorizationEndpoint with some additional
    // query parameters). Scopes and state can optionally be passed into this method.
    return _grant
        .getAuthorizationUrl(Uri.parse(redirectUrl), scopes: ['access_token']);
  }

  /// Either load an OAuth2 client from saved credentials or authenticate a new one
  Future<oauth2.Client?> handleAuthorizationResponse(Uri responseUrl) async {
    // Once the user is redirected to `redirectUrl`, pass the query parameters to
    // the AuthorizationCodeGrant. It will validate them and extract the
    // authorization code to create a new Client.

    return await _grant
        .handleAuthorizationResponse(responseUrl.queryParameters);
  }

  Future<Credentials?> authGrantPassword(username, password) async {
    // Make a request to the authorization endpoint that will produce the fully
    // authenticated Client.
    var client = await oauth2.resourceOwnerPasswordGrant(
        authorizationEndpoint, username, password,
        identifier: clientId, secret: clientSecret);
    saveCredentails(client.credentials);
    return client.credentials;
  }

  Future<Credentials?> loadCredentails() async {
    var exists = await _credentialsFile.exists();
    // return null;
    log('${exists.isBlank}');

    return exists && oauth2.Credentials != null
        ? oauth2.Credentials.fromJson(await _credentialsFile.readAsString())
        : null;
  }

  Future<Credentials> refreshToken() async {
    var credentials = await loadCredentails();

    try {
      var response = await http.post(
        Uri.parse(ConfigAPI.basrUrl + refreshTokenUrl),
        body: {
          'refresh_token': credentials!.refreshToken,
          'grant_type': 'refresh_token',
        },
        headers: {
          HttpHeaders.authorizationHeader: "Basic " +
              base64Encode(utf8.encode(OAuthClientService.clientId +
                  ':' +
                  OAuthClientService.clientSecret))
        },
      );

      var nCredentials = jsonDecode(response.body);

      if (response.statusCode == 200) {
        //Expiration has Datetime data type and
        //expires_in variable in second(example: 300) so should get the
        //current time then convert to second divided by 1000 then add
        //expires time in second then return it to milliseconds
        var expiration = (((DateTime.now().millisecondsSinceEpoch / 1000) +
                    nCredentials['expires_in']) *
                1000)
            .round();

        var cre = Credentials(
          nCredentials['access_token'],
          expiration: DateTime.fromMillisecondsSinceEpoch(expiration),
          refreshToken: nCredentials['refresh_token'],
        );
        await saveCredentails(cre);

        return cre;
      } else {
        throw Exception(nCredentials.toString());
      }
    } catch (e) {
      printError(
          info:
              'Oauth client service exception refreshToken:  ${e.toString()}');
      rethrow;
    }
  }

  Future<bool> saveCredentails(Credentials? credentials) async {
    await _credentialsFile.writeAsString(credentials!.toJson());
    this.credentials = credentials;
    return true;
  }

  Future<bool> removeCredentails() async {
    await _credentialsFile.writeAsString('');
    _credentialsFile.delete();
    credentials = null;
    return true;
  }

  bool sessionIsEmpty() {
    if (credentials == null) return true;
    return false;
  }

  bool sessionIsExpired() {
    if (sessionIsEmpty()) return true;
    var expirationTime =
        ((credentials!.expiration!.millisecondsSinceEpoch) / 1000);
    int currentTimestamp = HelperMixin.getTimestamp();
    bool isExceeded = (expirationTime -
            ConfigAPI.sessionTimeoutThreshold -
            currentTimestamp) <=
        0;

    printInfo(
        info:
            'Expired in: ${credentials != null ? (expirationTime - ConfigAPI.sessionTimeoutThreshold - currentTimestamp) / 60 : 0} mins -- isExceeded: ${isExceeded.toString()}');
    return isExceeded;
  }
}
