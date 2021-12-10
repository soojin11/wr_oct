import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ini/ini.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/model/const/style/text.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';

class runErrorStatusController extends GetxController {
  // runError() {
  //   if (openAllSpectrometers() == 1) {
  //     RxString textmsg = 'RUN'.obs;
  //   } else if (Get.find<OesController>().inactiveBtn.value == false) {
  //     RxString textmsg = 'STOP'.obs;
  //   } else if (true) {
  //      RxString textmsg = 'SIMULATION'.obs;
  //   }
  // }

  RxString textmsg = Get.find<OesController>().inactiveBtn.value == false
      ? 'STOP'.obs
      : 'SIMULATION'.obs;
  RxBool connect = false.obs;
  RxBool setInactive = false.obs;
}

class RunErrorStatus extends GetView<runErrorStatusController> {
  const RunErrorStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
              color: Get.find<OesController>().inactiveBtn.value == false
                  ? Colors.red
                  : Colors.yellow[700]),
          width: 300,
          height: 80,
          child: Row(
            children: [
              Center(
                child: Text(
                  controller.textmsg.value,
                  style: WrText.WrLeadingFont,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
