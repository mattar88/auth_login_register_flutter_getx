import 'package:general_directorate_grains/mixins/helper_mixin.dart';

class TokenModel with HelperMixin {
  String accessToken;
  int expiresIn;
  String tokenType;
  String scope;
  String refreshToken;
  int timestamp;

  TokenModel(
      {required this.accessToken,
      required this.expiresIn,
      required this.tokenType,
      required this.scope,
      required this.refreshToken,
      required this.timestamp});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
        accessToken: json['access_token'],
        expiresIn: int.parse(json['expires_in']),
        tokenType: json['token_type'],
        scope: json['scope'],
        refreshToken: json['refresh_token'],
        timestamp: json['timestamp'] != null
            ? int.parse(json['timestamp'])
            : HelperMixin.getTimestamp());
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'expires_in': expiresIn.toString(),
      'token_type': tokenType,
      'scope': scope,
      'refresh_token': refreshToken,
      'timestamp': timestamp.toString()
    };
  }

  TokenModel copyWith(
      {String? accessToken,
      int? expiresIn,
      String? tokenType,
      String? scope,
      String? refreshToken,
      int? timestamp}) {
    return TokenModel(
      accessToken: accessToken ?? this.accessToken,
      expiresIn: expiresIn ?? this.expiresIn,
      tokenType: tokenType ?? this.tokenType,
      scope: scope ?? this.scope,
      refreshToken: refreshToken ?? this.refreshToken,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  void printAttributes() {
    print("accessToken: ${this.accessToken}\n");
    print("expiresIn: ${this.expiresIn}\n");
    print("tokenType: ${this.tokenType}\n");
    print("scope: ${this.scope}\n");
    print("refreshToken: ${this.refreshToken}\n");
  }
}
