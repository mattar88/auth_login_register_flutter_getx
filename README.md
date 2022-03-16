# Authentication Login and Register with Flutter Getx
Flutter Getx project that covered a best architecture and functionality of Authentication, Login and Register using Rest API
In this project I used the powerful features of Getx like state management, Dependency injection, Route management, localStorage...

## Screenshots
| Login Screen  | Register screen | Offline pop-up  |
| :------------ | :------------- | :------------ |
| <img src="https://raw.githubusercontent.com/mattar88/auth_login_register_flutter_getx/main/screenshots/1_login.png" width="300"> | <img src="https://raw.githubusercontent.com/mattar88/auth_login_register_flutter_getx/main/screenshots/2_register.png" width="300"> |<img src="https://raw.githubusercontent.com/mattar88/auth_login_register_flutter_getx/main/screenshots/3_offline.png" width="300"> |

## Architecture 
 <img src="https://raw.githubusercontent.com/mattar88/auth_login_register_flutter_getx/main/screenshots/architecture.png" width="300">
 
## Flutter Version
``````
PS > flutter --version
Flutter 2.10.1 • channel stable • https://github.com/flutter/flutter.git
Framework • revision db747aa133 (5 weeks ago) • 2022-02-09 13:57:35 -0600
Engine • revision ab46186b24
Tools • Dart 2.16.1 • DevTools 2.9.2

``````

## Change the project name
1. flutter clean
2. ``````Ctrl+Shift+F`````` then Search and replace all ``````auth_login_register_flutter_getx`````` with ``````NEW_PROJECT_NAME``````
3. Search for ``````auth_login_register_flutter_getx`````` in the project folder, and replace them with ``````NEW_PROJECT_NAME`````` one by one. Some of them are in the text files, make sure that you have changed them too.

## Installation
1. Download Flutter version mentioned above
2. Clone the project

3. Open`````` lib  > confi > config_api.dart`````` then add the values to variables

4. Open `````` lib > services > auth_api_service.dart``````  then put your REST API URL by changing the following variables values
``````
 signUpUrl = '/api/user';
 signInUrl = '/oauth2/token';
 refreshTokenUrl = '/oauth2/token';
``````

