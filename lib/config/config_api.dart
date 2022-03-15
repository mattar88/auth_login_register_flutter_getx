class ConfigAPI {
  static const String basrUrl = 'BASE_URL';
  static const String clientId = 'CLIENT_ID';
  static const String clientSecret = 'CLIENT_SECRET';
  static const int sessionTimeoutThreshold =
      300; // Will refresh the access token 5 minutes before it expires
}
