import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingOverlay {
  static void hide() {
    Get.back();
  }

  static void show({String? message}) {
    Get.dialog(
      CupertinoAlertDialog(
        title: Row(children: [
          // Icon(Icons.signal_wifi_off_outlined),
          Container(
              // margin: EdgeInsets.only(left: 5),
              child: Text(message ?? 'loading...')),
        ]),
        content: const Center(child: CircularProgressIndicator()),
      ),
      barrierDismissible: true,
    );

    //   showDialog(
    //       context: _context,
    //       barrierDismissible: false,
    //       builder: (_) => _FullScreenLoader());
    // }

    // Future<T> during<T>(Future<T> future) {
    //   show();
    //   return future.whenComplete(() => hide());
    // }

    // factory LoadingOverlay.of(BuildContext context) {
    //   return LoadingOverlay._create(context);
    // }

    // Widget render() {
    //   return _FullScreenLoader();
    // }
  }

// class _FullScreenLoader extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
//         child: const Center(child: CircularProgressIndicator()));
//   }
}
