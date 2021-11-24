import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/model/const/style/text.dart';
import 'package:wr_ui/view/appbar/actions/setting/setting_dialog_final.dart';
class SettingController extends GetxController{
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  RxString deviceName = 'firstDevice'.obs;
  RxDouble interval = 200.22.obs;
  RxString unit = 'aa'.obs;

  RxString chartName = 'First Chart'.obs;
  RxString chartColor = 'green'.obs;
  RxDouble scaleValue = 0.0.obs;
  RxString delayTime = ''.obs;
  RxString exposureTime = '100'.obs;
  RxString deviceSimul = ''.obs;
}

class SettingMenu extends StatefulWidget {
  @override
  State<SettingMenu> createState() => _SettingMenuState();
}

class _SettingMenuState extends State<SettingMenu> {
  Map<String, dynamic> settingsPage = <String, dynamic>{
    //디바이스세팅
    'deviceName': Get.find<SettingController>().deviceName.value,
    'interval': Get.find<SettingController>().interval.value,
    'unit': Get.find<SettingController>().unit.value,
    'deviceSimul' : Get.find<SettingController>().deviceSimul.value,

    ///차트세팅
    'chartName': Get.find<SettingController>().chartName.value,
    'chartColor': Get.find<SettingController>().chartColor.value,
    'chartTheme': 'bar type',
    'seriesType': 'aaa', //chartTheme이랑 seriesType 은.. 일단 뻈어요..-21.11.24수진
    'scaleValue': Get.find<SettingController>().scaleValue.value,
    'delayTime' : Get.find<SettingController>().delayTime.value,
    'exposureTime' : Get.find<SettingController>().exposureTime.value
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton.icon(
        onPressed: () {
          settingsDialog(context, settingsPage)
              .then((Map<String, dynamic> settings) {
            setState(() {
              settingsPage = settings;
            });
            print(settingsPage);
          });
        },

        // onPressed: () {
        //   print('세팅다이얼로그창띄울곳');

        //   showDialog(
        //       //배경 안어둡게
        //       barrierDismissible: false,
        //       barrierColor: null,
        //       //배경 안어둡게
        //       context: context,
        //       builder: (BuildContext context) {
        //         return AlertDialog(
        //           scrollable: true,
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.all(Radius.circular(20))),
        //           title: Column(
        //             children: [
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.end,
        //                 children: [
        //                   IconButton(
        //                       onPressed: () {
        //                         print('세팅창 닫음');

        //                         Navigator.of(context).pop();
        //                       },
        //                       icon: Icon(
        //                         Icons.close,
        //                         color: wrColors.wrPrimary,
        //                       ))
        //                 ],
        //               ),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: [
        //                   Text('Setting'),
        //                 ],
        //               ),
        //             ],
        //           ),
        //           content: SingleChildScrollView(
        //             child: ListBody(
        //               children: [
        //                 Column(
        //                   children: [SettingContnet()],
        //                 )
        //               ],
        //             ),
        //           ),
        //           actions: [
        //             ElevatedButton(
        //               style:
        //                   ElevatedButton.styleFrom(primary: wrColors.wrPrimary),
        //               onPressed: () {
        //                 print('세팅적용');
        //                 Navigator.of(context).pop();
        //               },
        //               child: Text(
        //                 'Apply',
        //                 style: TextStyle(color: Colors.white),
        //               ),
        //             ),
        //             OutlinedButton(
        //               style:
        //                   OutlinedButton.styleFrom(primary: wrColors.wrPrimary),
        //               onPressed: () {
        //                 print('세팅창 닫음');
        //                 Navigator.of(context).pop();
        //               },
        //               child: Text('Cancel'),
        //             )
        //           ],
        //         );
        //       });
        // },

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
