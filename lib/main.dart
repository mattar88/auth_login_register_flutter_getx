import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';
import '../services/auth_api_service.dart';
import 'bindings/app_binding.dart';
import 'controllers/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();
  runApp(const MyApp());
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
  AuthApiService authApiService = Get.put(AuthApiService());
  await authApiService.initCredentials();
  Get.put(AuthController(authApiService), permanent: true);
  log('Initialize');
}
