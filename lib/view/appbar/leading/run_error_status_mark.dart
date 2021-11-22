import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ini/ini.dart';
import 'package:wr_ui/model/const/style/text.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';

class runErrorStatusController extends GetxController {
  // void runStatus() {
  //   var aa = Get.find<iniControllerWithReactive>().Readini();
  //   Config config = Get.find<iniControllerWithReactive>().Readini();
  //   if (config.hasSection('OES')) {
  //     print('has section oes');
  //   } else {
  //     print('oes section 없어');
  //   }
  // }
}

class RunErrorStatus extends GetView<runErrorStatusController> {
  const RunErrorStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: ElevatedButton(
        onPressed: () {
          Get.find<iniControllerWithReactive>().iniWriteSave();
        },
        child: Text(
          'Run/Error status',
          style: WrText.WrLeadingFont,
        ),
      ),
    );
  }
}
