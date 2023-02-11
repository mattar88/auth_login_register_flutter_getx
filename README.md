# Authentication Login and Register with Flutter Getx
Flutter Getx project that covered a best architecture and functionality of Authentication, Login and Register using Rest API
In this project I used the powerful features of Getx like state management, Dependency injection, Route management, localStorage...

# OAuth Grant Types
1. OAuth 2.0 Authorization Code Grant
2. Resource Owner Password Credentials Grant

## Screenshots
| Login Screen  | Register screen | Offline pop-up  |
| :------------ | :------------- | :------------ |
| <img src="https://raw.githubusercontent.com/mattar88/auth_login_register_flutter_getx/main/screenshots/1_login.png" width="300"> | <img src="https://raw.githubusercontent.com/mattar88/auth_login_register_flutter_getx/main/screenshots/2_register.png" width="300"> |<img src="https://raw.githubusercontent.com/mattar88/auth_login_register_flutter_getx/main/screenshots/3_offline.png" width="300"> |

## Architecture 
 <img src="https://raw.githubusercontent.com/mattar88/auth_login_register_flutter_getx/main/screenshots/architecture.png" width="300">
 
 ``````
 #In this repository we will deposit our routes and pages. 
 - /routes
     # Contains the settings of pages(name Binding, midellwares,..).
     - app_pages.dart
     # Contains name of pages
     - app_routes.dart 
 #Bindings are classes where we can declare our dependencies and then 'bind' them to the routes page.    
 - /binding
     # In this binding inject the dependencies that used as soon as the app starts 
     contains ConnectivityServices to check if there is Internet Connectivity
     - app_binding.dart
     # We inject the home services api and the home controller
     - home_binding.dart 
     # We inject the login api services and the login controller
     - login_binding.dart
     # We inject the register api services and the signup controller
     - signup_binding.dart
 # In this repository we declare the middleware of routes    
 - /middlewares
     # This middleware is use by home route to check if there is an access token
     in the local storage before open the Home page or redirect to Login page
     - auth_middleware.dart
  # In this repository we declare the mixins classes where is the StateMixin and the common functionality
  # You can use the StateMixin to handle your UI state in a more efficient and clean way, when you perform asynchronous tasks
 - /mixins
     # We declare the helper class that contains common functionality that implement by multiple classes
     - helper_mixin.dart  
  #In this repository we declare the Controllers which responsible for controlling the application logic and acts as the coordinator between the Screens and the Models.
  #Here our repositories are just classes that will mediate the communication between our controller and our data.
  # Our controllers won't need to know where the data comes from, And inside it will contain all its functions 
  # that will request data from a local api or REST api.
 - /services
     #In this file we declare all the constants that needed to communicate with server using http request 
     # and its responsible to authentication and authorization requests.
     - api_service.dart
     #Contains the sigin and signup rest api functions
     - auth_api_service.dart
     #Contains the functions that communicate with the local storage to CRUD the access token and other variables using get_storage package
     - cache_service.dart 
     #It responsible to the status of internet connection it use internet_connection_checker package
     - connectivity_service.dart
     #Contains the REST api service of home
     - home_api_service.dart
      #Contains the REST api service of home
     -oauth_client_service.dart
     #Contains the endpoints and the  functionality for Client  OAuth2
 - /controllers
     # Responsible for signin and signup and share this functionality with login and signup controllers
     - auth_controller.dart  
     #Contains the logic and the functionality of home page
     - home_controller.dart  
     #Containes the logic of Login page(Form validations, sigin request and other) and inherit some functionality from auth controller
     - login_controller.dart  
     #Containes the logic of Login page and inherit some functionality from auth controller
     - signup_controller.dart.dart
  #In this repository we declare the Classes that represents the core information that application is being used to access and manipulate   
 - /models
     - home_model.dart  
     #Used by auht controller to represent the token loaded when login or register
     - token_model.dart
 #In this repository we declare the Classes that contains a widgets and data form widgets that produces a view to mobile screen or  browser
 - /screens
     - home_model.dart  
     #Used by auht controller to represent the token loaded when login or register
     - token_model.dart  
#Contains global widgets     
- /widgets
    -loading_overlay.dart
#Contains global configuration     
- /config
    -config_api.dart
#Here is declared the main configuration of application (Theme, Initial route, Initial binding, Pages)   
-main.dart     
 ``````       
 
## Flutter Version
``````
PS > flutter --version
Flutter 3.3.2 • channel stable • https://github.com/flutter/flutter.git
Framework • revision e3c29ec00c (8 weeks ago) • 2022-09-14 08:46:55 -0500
Engine • revision a4ff2c53d8
Tools • Dart 2.18.1 • DevTools 2.15.0

``````
## Dependencies:
``````
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  get: ^4.6.5
  equatable: ^2.0.3
  http: ^0.13.4
  get_storage: ^2.0.3
  internet_connection_checker: ^0.0.1+3
  oauth2: ^2.0.0
  webview_flutter: ^3.0.4
``````

## How to update app information and continue development for your own project?

1. Rename root folder name
2. Update project name and description from pubspec.yaml. 
3. Update app launcher name and icon. [Reference](https://medium.com/@vaibhavi.rana99/change-application-name-and-icon-in-flutter-bebbec297c57)
4. Update your app's package name by [running this command](https://pub.dev/packages/change_app_package_name):

`flutter pub run change_app_package_name:main your_package_name`

## Installation
1. Download Flutter version mentioned above
2. Clone the project

3. Open`````` lib  > confi > config_api.dart`````` then set the variables

4. Open `````` lib > services > auth_api_service.dart``````  then set your REST API URL by changing the following variables
``````
 signUpUrl = '/jsonapi/user/register';
 signInUrl = '/oauth2/token';
``````
5. Open `````` lib > services > oauth_client_service.dart``````  then set your REST API URL by changing the following variables
``````
 authorizationUrl = '';
 refreshTokenUrl = '';
 redirectUrl = '';
``````
