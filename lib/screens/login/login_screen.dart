import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config_api.dart';
import '../../controllers/login/login_controller.dart';
import '../../routes/app_pages.dart';
import '../../widgets/loading_overlay.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  void checkHeaderMessages(duration) {
    if (Get.arguments != null &&
        Get.arguments.containsKey('message') &&
        Get.arguments['message'].containsKey('status_text') &&
        Get.arguments['message']['status_text'] == 'session_expired') {
      var message = Get.arguments['message']['body'];
      Get.snackbar(
        "Warning",
        message.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white),
        shouldIconPulse: true,
        barBlur: 20,
      );
      Get.arguments.remove('message');
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(checkHeaderMessages);

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('LOGIN'),
            automaticallyImplyLeading: false,
          ),
          body: Container(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (ConfigAPI.loginWithPassword)
                      Column(children: [
                        TextFormField(
                          // key: const Key('username'),
                          controller: controller.emailController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'Username',
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: controller.validator,
                        ),
                        TextFormField(
                          // key: const Key('password'),
                          controller: controller.passwordController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.security),
                            hintText: 'Password',
                          ),
                          validator: controller.validator,
                          obscureText: true,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (controller.loginFormKey.currentState!
                                  .validate()) {
                                LoadingOverlay.show(message: 'Login...');
                                try {
                                  await controller.login();
                                  Get.offAllNamed(Routes.HOME);
                                } catch (err, _) {
                                  printError(info: err.toString());
                                  LoadingOverlay.hide();
                                  Get.snackbar(
                                    "Error",
                                    err.toString(),
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor:
                                        Colors.red.withOpacity(.75),
                                    colorText: Colors.white,
                                    icon: const Icon(Icons.error,
                                        color: Colors.white),
                                    shouldIconPulse: true,
                                    barBlur: 20,
                                  );
                                } finally {}

                                controller.loginFormKey.currentState!.save();
                              }
                            },
                            child: const Text('login'))
                      ]),
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            Get.toNamed(Routes.LOGIN_WEBVIEW);
                          } catch (err, _) {
                            printError(info: err.toString());
                            LoadingOverlay.hide();
                            Get.snackbar(
                              "Error",
                              err.toString(),
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red.withOpacity(.75),
                              colorText: Colors.white,
                              icon:
                                  const Icon(Icons.error, color: Colors.white),
                              shouldIconPulse: true,
                              barBlur: 20,
                            );
                          } finally {}
                        },
                        child: const Text('login with browser')),
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(Routes.SIGNUP);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
