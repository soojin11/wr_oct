import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wr_ui/view/chart/switch_chart.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';
import 'log_save.dart';

class LogListController extends GetxController {
  RxList logData = [' Start Program'].obs;
  //RxBool rederror = false.obs;
  String event = '[Event Trigger]';
  String btnPress = 'button is pressed';
  DateTime current = DateTime.now();
  String logTime = logfileTime();
  String screenLogTime = screenTime();

  @override
  void onInit() {
    //ever(logData, (_) => logData.add('클릭');
    super.onInit();
  }

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
    logData.add(' Setting $btnPress');
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} [Event Trigger] Setting $btnPress' + '\n');
  }

  void clickedStop() async {
    saveLog();
    logData.add(' Stop $btnPress');
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} $event Stop $btnPress' + '\n');
  }

  void clickedStart() async {
    saveLog();
    logData.add(' Start $btnPress');
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} $event Start $btnPress' + '\n');
  }

  void startCsv() async {
    saveLog();
    logData.add(' Save start $btnPress');
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} [Event Trigger] Save start $btnPress' + '\n');
  }

  void stopCsv() async {
    saveLog();
    Get.find<LogController>().logSave();

    logData.add(' Save stop $btnPress');
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} [Event Trigger] Save stop $btnPress' + '\n');
  }

  void cConfigSave() async {
    saveLog();
    logData.add(
        '${screenLogTime} Exposure time has been changed to ${Get.find<iniController>().exposureTime.value}');
    Get.find<LogController>().loglist.add(
        '${logfileTime} Exposure time has been changed to ${Get.find<iniController>().exposureTime.value}' +
            '\n');
    logData.add(' Save Config');
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} [Event Trigger] Save setting $btnPress' + '\n');
  }

  void cModeChage() async {
    saveLog();
    logData.add(' Changed Mode');
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} Mode $btnPress' + '\n');
  }

  void cExit() async {
    saveLog();
    Get.find<LogController>().loglist.add('${logfileTime()} Exit' + '\n');
  }

  void clickedHover() async {
    saveLog();
    String select =
        'Num${Get.find<chooseChart>().chartNum.value} chart is selected';
    logData.add('${screenLogTime} $select');
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
        height: 395,
        child: Obx(() {
          if (controller.logData.length < 0) {
            return Center(child: Text('log does not exist.'));
          } else {
            return SafeArea(
              child: Scrollbar(
                //isAlwaysShown: true,
                child: SingleChildScrollView(
                  child: ListView.builder(
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
                                children: [
                                  Text(
                                    '${screenTime()}',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: Colors.black,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(height: 20),
                                      Text(
                                        '${controller.logData[index]}\r\n',
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Text('${screenTime()}'),
                                  VerticalDivider(
                                    color: Colors.black,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(height: 20),
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
        }));
  }
}
