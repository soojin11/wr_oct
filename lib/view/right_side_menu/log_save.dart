import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LogController extends GetxController {
  static LogController get to => Get.find();
  RxString path = ''.obs;
  RxBool fileSave = false.obs;
  RxList loglist = RxList.empty();

  Future<File> logSave() async {
    DateTime current = DateTime.now();
    final String fileName = DateFormat('HH').format(current);
    final String yearName = DateFormat('yyyy').format(current);
    final String monthName = DateFormat('MM').format(current);
    final String dayName = DateFormat('dd').format(current);

    await Directory('./Log/$yearName/$monthName/$dayName')
        .create(recursive: true);

    path.value = "./Log/$yearName/$monthName/$dayName/$fileName.txt";

    File file = File(path.value);

    List<dynamic> logData = [];
    logData.addAll(Get.find<LogController>().loglist);
    String addLogFile = logData.join();

    print("log file in");
    String intergrationColumn = addLogFile;

    return file.writeAsString(intergrationColumn);
  }
}
