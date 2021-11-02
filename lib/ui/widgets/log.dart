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
    logData.add('Stop 클릭');
  }

  void clickedStart() async {
    logData.add('Start 클릭');
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
