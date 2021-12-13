import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ini/ini.dart';
import 'package:wr_ui/model/const/style/text.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';

class runErrorStatusController extends GetxController {
  RxString textmsg = 'Stop'.obs;
  RxBool connect = false.obs;
  Rx<Color> runColor = Color(0xFFD12F2D).obs;

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
              color: controller.runColor.value),
          
          width: 300,
          child: Center(
            child: Text(
              controller.textmsg.value,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)
            ),
          ),
        ),
      ),
    );
  }
}