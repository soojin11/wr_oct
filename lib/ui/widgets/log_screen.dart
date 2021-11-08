import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    logData.add('Stop button is pressed');
  }

  void clickedStart() async {
    logData.add('Start buttton is pressed');
  }

  void clickedCsv() async {
    logData.add('Start Saving');
  }
  void stopCsv() async {
    logData.add('Stop Saving');
  }

  void clickedIni() async {
    logData.add('Save config');
  }

  void clickedReset() async {
    logData.add('Reset button is pressed');
  }
}

// class Logs {
//   final String hey;
//   Logs({required this.hey});
// }

class LogList extends GetView<LogListController> {
  const LogList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //decoration: BoxDecoration(border: Border.all(width: 1)),
        width: 200,
        height: 100,
        child: Obx(
          () => ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: controller.logData.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 20,
                child: Text('${controller.logData[index]}'),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ));
  }
}
