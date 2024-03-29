import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';
import '../../routes/app_pages.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.find<AuthController>().signOut();
                Get.offAllNamed(Routes.LOGIN);
              },
              child:
                  const Text("Signout", style: TextStyle(color: Colors.white)),
            )
          ],
          // leadingWidth: double.infinity,
          title: const Text(
            'Auth Login Register Flutter Getx',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28),
          ),
        ),
        body: Obx(
          () {
            return SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.timer_sharp),
                            Text(
                              'The session expired in:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(
                          child: Text(controller.sessionTime.value),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'Credentials:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        ListTile(
                            leading: const Text(
                              'Access token',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            title:
                                Text(controller.credentails.value.accessToken)),
                        ListTile(
                            leading: const Text(
                              'Refresh token',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            title: Text(
                                controller.credentails.value.refreshToken!)),
                        ListTile(
                            leading: const Text(
                              'CanRefresh',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            title: Text(controller.credentails.value.canRefresh
                                .toString())),
                        ListTile(
                            leading: const Text(
                              'Expiration',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            title: Text(controller.credentails.value.expiration
                                .toString())),
                        ListTile(
                            leading: const Text(
                              'idToken',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            title: Text(controller.credentails.value.idToken
                                .toString())),
                        ListTile(
                            leading: const Text(
                              'isExpired',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            title: Text(controller.credentails.value.isExpired
                                .toString())),
                        ListTile(
                            leading: const Text(
                              'tokenEndPoint',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            title: Text(controller
                                .credentails.value.tokenEndpoint
                                .toString())),
                        ListTile(
                            leading: const Text(
                              'Scopes',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            title: Text(controller.credentails.value.scopes
                                .toString())),
                      ],
                    )));
          },
        ));
  }
}
