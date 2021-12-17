import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ini/ini.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/model/const/style/text.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';

class runErrorStatusController extends GetxController {
  RxString textmsg = 'S T O P'.obs;
  RxBool connect = false.obs;
  Rx<Color> statusColor = Color(0xFFD12F2D).obs;
}

class RunErrorStatus extends GetView<runErrorStatusController> {
  const RunErrorStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: controller.statusColor.value,
        // decoration: BoxDecoration(color: controller.statusColor.value),
        width: 300,
        height: 85,
        child: Center(
          child: Text(
            controller.textmsg.value,
            style: WrText.WrFont,
          ),
        ),
      ),
    );
  }
}
