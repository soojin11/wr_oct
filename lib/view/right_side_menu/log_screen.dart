import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wr_ui/view/chart/switch_chart.dart';
import 'log_save.dart';

class LogListController extends GetxController {
  RxList logData = RxList.empty();
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

  void clickedStop() async {
    saveLog();
    String logTime = logfileTime();
    String screenLogTime = screenTime();
    logData.add('${screenLogTime} Stop $btnPress');
    Get.find<LogController>()
        .loglist
        .add('${logTime} $event Stop $btnPress' + '\n');
  }

  void clickedStart() async {
    saveLog();
    String logTime = logfileTime();
    String screenLogTime = screenTime();
    logData.add('${screenLogTime} Start $btnPress');
    Get.find<LogController>()
        .loglist
        .add('${logTime} $event Start $btnPress' + '\n');
  }

  void startCsv() async {
    saveLog();
    String logTime = logfileTime();
    String screenLogTime = screenTime();
    logData.add('${screenLogTime} Save start $btnPress');
    Get.find<LogController>()
        .loglist
        .add('${logTime} [Event Trigger] Save start $btnPress' + '\n');
  }

  void stopCsv() async {
    saveLog();
    String logTime = logfileTime();
    String screenLogTime = screenTime();
    Get.find<LogController>().logSave();

    logData.add('${screenLogTime} Save stop $btnPress');
    Get.find<LogController>()
        .loglist
        .add('${logTime} [Event Trigger] Save stop $btnPress' + '\n');
  }

  void cConfigSave() async {
    saveLog();
    String logTime = logfileTime();
    String screenLogTime = screenTime();
    logData.add('${screenLogTime} Save Config');
    Get.find<LogController>()
        .loglist
        .add('${logTime} [Event Trigger] Save setting $btnPress' + '\n');
    //여기 값이 어떻게 바뀌었는지도 넣는게 좋은가?
  }

  void cModeChage() async {
    saveLog();
  }

  void cExit() async {
    saveLog();
  }

  void clickedHover() async {
    saveLog();
    String logTime = logfileTime();
    String screenLogTime = screenTime();
    String aaa =
        'Num${Get.find<chooseChart>().chartNum.value} chart is selected';
    logData.add('${screenLogTime} $aaa');
    Get.find<LogController>()
        .loglist
        .add('${logTime} [Event Trigger] $aaa' + '\n');
  }
}

saveLog() {
  Get.find<LogController>().fileSave.value = true;
  Get.find<LogController>().logSave();
}

screenTime() {
  DateTime current = DateTime.now();
  String ms = DateTime.now().millisecondsSinceEpoch.toString();
  int msLength = ms.length;
  int third = int.parse(ms.substring(msLength - 3, msLength));
  String screenDate = '${DateFormat('HH:mm:ss').format(current)}.$third';
  return screenDate;
}

logfileTime() {
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
        //decoration: BoxDecoration(border: Border.all(width: 1)),
        width: 350,
        height: 395,
        child: Obx(() {
          if (controller.logData.length < 0) {
            return Center(child: Text('log does not exist.'));
          } else {
            return SafeArea(
              // child: Scrollbar(
              //   isAlwaysShown: true,
              //     controller: scrollCtrl,
              child: SingleChildScrollView(
                child: ListView.builder(
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  padding: const EdgeInsets.all(8),
                  shrinkWrap: true,
                  itemCount: controller.logData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('${controller.logData[index]}'),
                    );
                  },
                ),
              ),
              //),
            );
          }
        }));
  }
}
