import 'dart:async';

import 'package:get/get.dart';
import 'package:wr_ui/service/routes/app_pages.dart';

class SplashController extends GetxController {
  final count = 0.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    loading();
  }

  Future<void> loading() async {
    Timer(Duration(seconds: 0), () {
      Get.offAndToNamed(Routes.HOME);
    });
  }
}
