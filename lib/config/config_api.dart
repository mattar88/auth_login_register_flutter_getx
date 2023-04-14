class ConfigAPI {
  //Example: https://www.example.com without /
  static const String basrUrl =
      'https://dev-flutter-with-drupal.pantheonsite.io';
  static const int sessionTimeoutThreshold =
      0; // Will refresh the access token 5 minutes before it expires
  static const bool loginWithPassword = true; // if false hide the form login
  //if false hide the fields password and confirm password from signup form
  //for security reason and the password generated after verification mail
  static const bool signupWithPassword = true;
}
