import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wr_ui/view/chart/switch_chart.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';
import 'log_save.dart';

class LogListController extends GetxController {
  RxList logData = ['Start Program'].obs;
  //RxBool rederror = false.obs;
  String event = '[Event Trigger]';
  String btnPress = 'button is pressed';
  DateTime current = DateTime.now();
  String logTime = logfileTime();
  String screenLogTime = screenTime();

  @override
  void onClose() {
    LogListController;
    super.onClose();
  }

  void programStart() async {
    saveLog();
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} Start program' + '\n');
  }

  void settingBtn() async {
    saveLog();
    logData.add('Setting');
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} [Event Trigger] Setting $btnPress' + '\n');
  }

  void clickedStop() async {
    saveLog();
    logData.add('Stop $btnPress');
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} $event Stop $btnPress' + '\n');
  }

  void clickedStart() async {
    saveLog();
    logData.add('Start $btnPress');
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} $event Start $btnPress' + '\n');
  }

  void startCsv() async {
    saveLog();
    logData.add('Save start');
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} [Event Trigger] Save start $btnPress' + '\n');
  }

  void stopCsv() async {
    saveLog();
    Get.find<LogController>().logSave();

    logData.add('Save stop');
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} [Event Trigger] Save stop $btnPress' + '\n');
  }

  void cConfigSave() async {
    saveLog();
    logData.add('OES Comport : ${Get.find<iniController>().oes_comport.value}');
    for (var i = 0; i < 5; i++) {
      logData.add(
          'VIZ${i + 1} Comport : COM${Get.find<iniController>().vizComport[i]}');
    }
    logData.add('Auto Save : ${Get.find<iniController>().oesAutoSave.value}');
    logData
        .add('Viz Interval : ${Get.find<iniController>().viz_Interval.value}');
    logData
        .add('Exposure time : ${Get.find<iniController>().exposureTime.value}');
    logData.add(
        'Oes Integration : ${Get.find<iniController>().integrationTime.value}');
    logData.add(
        'Switching Time : ${Get.find<iniController>().waitSwitchingTime.value}');
    logData.add('Save Config');
    Get.find<LogController>().loglist.add(
        '${logfileTime} Exposure time has been changed to ${Get.find<iniController>().exposureTime.value}' +
            '\n');

    Get.find<LogController>().loglist.add(
        '${logfileTime()} [Event Trigger] Auto Save : ${Get.find<iniController>().oesAutoSave.value}\n${logfileTime()} [Event Trigger] Save setting $btnPress\n');
  }

  void cModeChage() async {
    saveLog();
    logData.add('Changed Mode');
    Get.find<LogController>().loglist.add(Get.isDarkMode
        ? '${logfileTime()}Changed bright Mode' + '\n'
        : '${logfileTime()}Changed dark Mode' + '\n');
  }

  void cExit() async {
    saveLog();
    Get.find<LogController>().loglist.add('${logfileTime()} Exit' + '\n');
  }

  void clickedHover() async {
    saveLog();
    String select =
        'Num${Get.find<chooseChart>().chartNum.value} chart is selected';
    logData.add('$select');
    Get.find<LogController>()
        .loglist
        .add('${logTime} [Event Trigger] $select' + '\n');
  }
}

saveLog() {
  Get.find<LogController>().fileSave.value = true;
  Get.find<LogController>().logSave();
}

String screenTime() {
  DateTime current = DateTime.now();
  String ms = DateTime.now().millisecondsSinceEpoch.toString();
  int msLength = ms.length;
  int third = int.parse(ms.substring(msLength - 3, msLength));
  String screenDate = '${DateFormat('HH:mm:ss').format(current)}.$third';
  return screenDate;
}

String logfileTime() {
  DateTime current = DateTime.now();
  String ms = DateTime.now().millisecondsSinceEpoch.toString();
  int msLength = ms.length;
  int third = int.parse(ms.substring(msLength - 3, msLength));
  String msDate = '${DateFormat('yyyy-MM-dd HH:mm:ss').format(current)}.$third';
  return msDate;
}

class LogList extends GetView<LogListController> {
  final ScrollController scrollCtrl = ScrollController();
  LogList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        height: 400,
        child: Obx(() {
          // if (controller.logData.length == 0) {
          //   return Center(child: Text('log does not exist.'));
          // } else {
          return SafeArea(
            child: Scrollbar(
              //isAlwaysShown: true,
              child: SingleChildScrollView(
                child: ListView.builder(
                  itemExtent: 50.0,
                  reverse: true,
                  controller: scrollCtrl,
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  padding: const EdgeInsets.all(8),
                  shrinkWrap: true,
                  itemCount: controller.logData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      //최신 인덱스이면 글자 강조되게
                      title: index == controller.logData.length - 1
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${screenTime()}',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 13),
                                Text(
                                  '${controller.logData[index]}\r\n',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${screenTime()}'),
                                SizedBox(width: 17),
                                Column(
                                  children: [
                                    Text('${controller.logData[index]}\r\n'),
                                  ],
                                ),
                              ],
                            ),
                    );
                  },
                ),
              ),
            ),
            //),
          );
        }
            // }
            ));
  }
}
