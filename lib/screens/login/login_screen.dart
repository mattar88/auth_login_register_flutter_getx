import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:auth_login_register_flutter_getx/controllers/login_controller.dart';
import 'package:auth_login_register_flutter_getx/routes/app_routes.dart';
import 'package:auth_login_register_flutter_getx/widgets/loading_overlay.dart';

import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                                backgroundColor: Colors.red.withOpacity(.75),
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
                        child: const Text('login')),
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(Routes.SIGNUP);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          Text(
                            'Create an account',
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
