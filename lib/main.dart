import 'dart:developer';

import '../services/oauth_client_service.dart';
import 'package:flutter/material.dart';

import '../routes/app_pages.dart';
import '../services/auth_api_service.dart';
import '../services/cache_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'bindings/app_binding.dart';
import 'controllers/auth_controller.dart';

Future<void> main() async {
  await initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Auth login Register with Flutter Getx',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // locale: LocalizationService.locale,
      // fallbackLocale: LocalizationService.fallbackLocale,
      // translations: LocalizationService(),
      initialRoute: Routes.HOME,
      initialBinding: AppBinding(),
      getPages: AppPages.pages,
    );
  }
}

Future<void> initializeApp() async {
  // await GetStorage.init();
  OAuthClientService _OAuthClientService = Get.put(OAuthClientService());
  await _OAuthClientService.initCredentials();
  Get.put(
      AuthController(Get.put(AuthApiService()), Get.put(OAuthClientService())),
      permanent: true);
  log('Initialize');
}
