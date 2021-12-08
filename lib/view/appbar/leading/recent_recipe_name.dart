import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChartName extends GetxController {
  RxString chartName = 'ALL'.obs;
}

class RecentRecipeName extends GetView<ChartName> {
  const RecentRecipeName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Text(controller.chartName.value,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
    ));
  }
}