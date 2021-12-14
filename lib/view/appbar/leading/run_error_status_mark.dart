import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ini/ini.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/model/const/style/text.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';

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
      () => NeuomorphicContainer(
        color: controller.statusColor.value,
        // decoration: BoxDecoration(color: controller.statusColor.value),
        width: 300,
        height: 85,
        intensity: 0.2,
        offset: Offset(10.0, 10.0),
        blur: 7,
        style: NeuomorphicStyle.Pressed,
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
