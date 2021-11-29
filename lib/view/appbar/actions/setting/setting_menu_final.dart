import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/model/const/style/text.dart';
import 'package:wr_ui/view/appbar/actions/setting/setting_dialog_final.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';

class SettingController extends GetxController {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  /////////////////디바이스세팅
  RxString deviceName = 'firstDevice'.obs;
  RxDouble interval = 200.22.obs;
  RxString unit = 'aa'.obs;
/////////////////////디바이스 세팅
////////////////////차트세팅
  RxString chartName = 'First Chart'.obs;
  RxString chartColor = 'green'.obs;
  RxDouble scaleValue = 0.0.obs;
  // RxString DelayTime = ''.obs;
  RxString ExposureTime = '0'.obs;
  RxString DelayTime = '0'.obs;
  RxString deviceSimul = ''.obs;
  RxInt savedValue = 0.obs;
  ////////////////////차트세팅
}

class SettingMenu extends StatefulWidget {
  @override
  State<SettingMenu> createState() => _SettingMenuState();
}

class _SettingMenuState extends State<SettingMenu> {
  // Map<String, dynamic> settingsPage = <String, dynamic>{
  //   //디바이스세팅
  //   'deviceName': Get.find<SettingController>().deviceName.value,
  //   'interval': Get.find<SettingController>().interval.value,
  //   'unit': Get.find<SettingController>().unit.value,
  //   'deviceSimul': Get.find<SettingController>().deviceSimul.value,

  //   ///차트세팅
  //   'chartName': Get.find<SettingController>().chartName.value,
  //   'chartColor': Get.find<SettingController>().chartColor.value,
  //   'chartTheme': 'bar type',
  //   'seriesType': 'aaa', //chartTheme이랑 seriesType 은.. 일단 뻈어요..-21.11.24수진
  //   'scaleValue': Get.find<SettingController>().scaleValue.value,
  //   'DelayTime': Get.find<SettingController>().DelayTime.value,
  //   'exposureTime': Get.find<iniControllerWithReactive>().ExposureTime.value,
  //   'DelayTime': Get.find<iniControllerWithReactive>().DelayTime.value
  // };
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton.icon(
        onPressed: () {
          settingsDialog(context);
          // settingsDialog(context, settingsPage)
          //     .then((Map<String, dynamic> settings) {
          //   setState(() {
          //     settingsPage = settings;
          //   });
          //   print(settingsPage);
          // });
        },
        icon: Icon(
          Icons.settings,
          color: Colors.white,
          size: 20,
        ),
        label: Text(
          'Setting',
          style: WrText.WrLeadingFont,
        ),
      ),
    );
  }
}
