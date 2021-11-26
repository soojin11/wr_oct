import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';

import 'log_save.dart';

class LogListController extends GetxController {
  RxList logData = RxList.empty();
  @override
  void onInit() {
    //ever(logData, (_) => logData.add('클릭');
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void clickedStop() async {
    // logData.add('Stop button is pressed');
    DateTime current = DateTime.now();
    String ms = DateTime.now().millisecondsSinceEpoch.toString();
    int msLength = ms.length;
    int third = int.parse(ms.substring(msLength - 3, msLength));
    String msDate =
        '${DateFormat('yyyy-MM-dd HH:mm:ss').format(current)}.$third';
    String screenDate = '${DateFormat('HH:mm:ss').format(current)}.$third';

    Get.find<LogController>()
        .loglist
        .add('${msDate} [Event Trigger] Stop button is pressed' + '\n');

    Get.find<LogController>().logSave();
    Get.find<LogController>().fileSave.value = true;
    logData.add('${screenDate} Stop button is pressed');
  }

  void clickedStart() async {
    //logData.add('Start buttton is pressed');
    DateTime current = DateTime.now();
    String ms = DateTime.now().millisecondsSinceEpoch.toString();
    int msLength = ms.length;
    int third = int.parse(ms.substring(msLength - 3, msLength));
    String msDate =
        '${DateFormat('yyyy-MM-dd HH:mm:ss').format(current)}.$third';
    String screenDate = '${DateFormat('HH:mm:ss').format(current)}.$third';

    logData.add('${screenDate} Start button is pressed');
    Get.find<LogController>()
        .loglist
        .add('${msDate} [Event Trigger] Start button is pressed' + '\n');
    Get.find<LogController>().logSave();
    Get.find<LogController>().fileSave.value = true;
  }

  void startCsv() async {
    //logData.add('Start Saving');
    DateTime current = DateTime.now();
    String ms = DateTime.now().millisecondsSinceEpoch.toString();
    int msLength = ms.length;
    int third = int.parse(ms.substring(msLength - 3, msLength));
    String msDate =
        '${DateFormat('yyyy-MM-dd HH:mm:ss').format(current)}.$third';
    String screenDate = '${DateFormat('HH:mm:ss').format(current)}.$third';

    logData.add('${screenDate} Start Saving Data');
    Get.find<LogController>()
        .loglist
        .add('${msDate} [Event Trigger] Save start button is pressed' + '\n');
    Get.find<LogController>().logSave();
    Get.find<LogController>().fileSave.value = true;
  }

  void stopCsv() async {
    //logData.add('Stop Saving');
    DateTime current = DateTime.now();
    String ms = DateTime.now().millisecondsSinceEpoch.toString();
    int msLength = ms.length;
    int third = int.parse(ms.substring(msLength - 3, msLength));
    String msDate =
        '${DateFormat('yyyy-MM-dd HH:mm:ss').format(current)}.$third';
    String screenDate = '${DateFormat('HH:mm:ss').format(current)}.$third';
    logData.add('${screenDate} Stop Saving Data');
    Get.find<LogController>()
        .loglist
        .add('${msDate} [Event Trigger] Save Stop button is pressed' + '\n');
    Get.find<LogController>().logSave();
    Get.find<LogController>().fileSave.value = true;
  }

  void clickedIni() async {
    //logData.add('Save config');
  }

  void clickedReset() async {
    //logData.add('Reset button is pressed');
  }
}

class LogList extends GetView<LogListController> {
  LogList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        //decoration: BoxDecoration(border: Border.all(width: 1)),
        width: 350,
        height: 395,
        //////////merge 할 때, 이 부분을 받을것,, 그래야지 시작정렬됨
        child: Obx(() {
          if (controller.logData.isEmpty) {
            return Center(
                child: Column(
              children: [
                Text('log does not exist.'),
              ],
            ));
          } else {
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: controller.logData.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 20,
                  child: Column(
                    children: [
                      Text(
                        '${controller.logData[index]}',
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            );
          }
        }));
  }
}
