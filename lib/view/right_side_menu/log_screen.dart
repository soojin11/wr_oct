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
    logData.add('${screenTime()} Stop $btnPress');
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} $event Stop $btnPress' + '\n');
  }

  void clickedStart() async {
    saveLog();
    logData.add('${screenTime()} Start $btnPress');
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} $event Start $btnPress' + '\n');
  }

  void startCsv() async {
    saveLog();
    logData.add('${screenTime()} Save start $btnPress');
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} [Event Trigger] Save start $btnPress' + '\n');
  }

  void stopCsv() async {
    saveLog();
    Get.find<LogController>().logSave();

    logData.add('${screenTime()} Save stop $btnPress');
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} [Event Trigger] Save stop $btnPress' + '\n');
  }

  void cConfigSave() async {
    saveLog();
    logData.add('${screenTime()} Save Config');
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} [Event Trigger] Save setting $btnPress' + '\n');
    //여기 값이 어떻게 바뀌었는지도 넣는게 좋은가?
  }

  void cModeChage() async {
    saveLog();
    logData.add('${screenTime()} Changed Mode');
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} Mode $btnPress' + '\n');
  }

  void cExit() async {
    saveLog();
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} Exit $btnPress' + '\n');
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
                    controller: scrollCtrl,
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    itemCount: controller.logData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text('${controller.logData[index]}\n'),
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
