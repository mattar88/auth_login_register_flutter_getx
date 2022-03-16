import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:auth_login_register_flutter_getx/routes/app_routes.dart';
import 'package:auth_login_register_flutter_getx/routes/app_pages.dart';
import 'package:auth_login_register_flutter_getx/services/auth_api_service.dart';
import 'package:auth_login_register_flutter_getx/services/cache_service.dart';
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
  await GetStorage.init();
  Get.put(AuthController(Get.put(AuthApiService()), Get.put(CacheService())),
      permanent: true);
  log('Initialize');
}
