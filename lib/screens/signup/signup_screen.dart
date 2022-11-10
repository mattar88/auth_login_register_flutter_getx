import 'dart:developer';

import 'package:flutter/material.dart';
import '../../config/config_api.dart';
import '../../controllers/signup_controller.dart';
import '../../routes/app_routes.dart';
import '../../widgets/loading_overlay.dart';

import 'package:get/get.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // LoadingOverlay overlay = LoadingOverlay.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.signupFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  key: controller.formUsernameFieldKey,
                  controller: controller.usernameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Username',
                  ),
                  focusNode: controller.usernameFocusNode,
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: controller.usernameValidator,
                ),
                TextFormField(
                  key: controller.formEmailFieldKey,
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.mail),
                    hintText: 'Email',
                  ),
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  focusNode: controller.emailFocusNode,
                  validator: controller.emailValidator,
                ),
                if (ConfigAPI.signupWithPassword)
                  TextFormField(
                    key: controller.formPasswordFieldKey,
                    controller: controller.passwordController,
                    focusNode: controller.passwordFocusNode,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.security),
                      hintText: 'Password',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: controller.passwordValidator,
                    obscureText: true,
                  ),
                if (ConfigAPI.signupWithPassword)
                  TextFormField(
                    key: controller.formConfirmPasswordFieldKey,
                    controller: controller.confirmPasswordController,
                    focusNode: controller.confirmPasswordFocusNode,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.security),
                      hintText: 'Confirm password',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: controller.confirmPasswordValidator,
                    obscureText: true,
                  ),
                ElevatedButton(
                    onPressed: () async {
                      if (controller.signupFormKey.currentState!.validate()) {
                        LoadingOverlay.show(message: 'Registering...');
                        try {
                          await controller.signup();

                          controller.signupFormKey.currentState!.save();
                          log('response signup');

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
                            icon: const Icon(Icons.error, color: Colors.white),
                            shouldIconPulse: true,
                            barBlur: 20,
                          );
                        } finally {}
                      }
                    },
                    child: const Text('Signup')),
                GestureDetector(
                  onTap: () {
                    Get.offAllNamed(Routes.LOGIN);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Do you have account?'),
                      const Text(
                        'Login',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
