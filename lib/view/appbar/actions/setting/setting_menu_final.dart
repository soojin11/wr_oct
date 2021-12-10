// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SettingController extends GetxController {
//   final GlobalKey<FormState> key = GlobalKey<FormState>();
//   /////////////////디바이스세팅
//   RxString deviceName = 'firstDevice'.obs;
//   RxDouble interval = 200.22.obs;
//   RxString unit = 'aa'.obs;
// /////////////////////디바이스 세팅
// ////////////////////차트세팅
//   RxString chartName = 'First Chart'.obs;
//   RxString chartColor = 'green'.obs;
//   RxDouble scaleValue = 0.0.obs;
//   // RxString delayTime = ''.obs;
//   RxString exposureTime = '100'.obs;
//   RxString delayTime = '100'.obs;
//   RxString integrationTime = '200'.obs;
//   RxString deviceSimul = ''.obs;
//   RxString mosChannel = '0'.obs;
//   ////////////////////차트세팅
// }

// class SettingMenu extends StatefulWidget {
//   @override
//   State<SettingMenu> createState() => _SettingMenuState();
// }

// class _SettingMenuState extends State<SettingMenu> {
//   Map<String, dynamic> settingsPage = <String, dynamic>{
//     //디바이스세팅
//     'deviceName': Get.find<SettingController>().deviceName.value,
//     'interval': Get.find<SettingController>().interval.value,
//     'unit': Get.find<SettingController>().unit.value,
//     'deviceSimul': Get.find<SettingController>().deviceSimul.value,

//     ///차트세팅
//     'chartName': Get.find<SettingController>().chartName.value,
//     'chartColor': Get.find<SettingController>().chartColor.value,
//     'chartTheme': 'bar type',
//     'seriesType': 'aaa', //chartTheme이랑 seriesType 은.. 일단 뻈어요..-21.11.24수진
//     'scaleValue': Get.find<SettingController>().scaleValue.value,
//     'delayTime': Get.find<SettingController>().delayTime.value,
//     'exposureTime': Get.find<SettingController>().exposureTime.value,
//     'delayTime': Get.find<SettingController>().delayTime.value
//   };
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: TextButton.icon(
//         onPressed: () {
//           settingsDialog(context, settingsPage)
//               .then((Map<String, dynamic> settings) {
//             setState(() {
//               settingsPage = settings;
//             });
//             print(settingsPage);
//           });
//         },
//         icon: Icon(
//           Icons.settings,
//           color: Colors.white,
//           size: 20,
//         ),
//         label: Text(
//           'Setting',
//           style: WrText.WrLeadingFont,
//         ),
//       ),
//     );
//   }
// }
