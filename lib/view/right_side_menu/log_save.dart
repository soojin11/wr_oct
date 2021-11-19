import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LogController extends GetxController {
  static LogController get to => Get.find();
  RxString path = ''.obs;
  RxBool fileSave = false.obs;
  RxList loglist = RxList.empty();

  @override
  void onInit() {
    super.onInit();
  }

  Future<File> logSave() async {
    DateTime current = DateTime.now();
    final String fileName = '${DateFormat('yyyyMMdd_hhmmss').format(current)}';
    print('$fileName');
    List<dynamic> LogData = [];
    List<List<dynamic>> addLogData = [];
    File file = File(path.value);
    addLogData.add(LogData);
    return file.writeAsString(addLogData.toString(), mode: FileMode.append);
  }

  Future<File> logSaveInit() async {
    DateTime current = DateTime.now();
    final String fileName = DateFormat('HH').format(current);
    final String yearName = DateFormat('yyyy').format(current);
    final String monthName = DateFormat('MM').format(current);
    final String dayName = DateFormat('dd').format(current);

    await Directory('./Log/$yearName/$monthName/$dayName')
        .create(recursive: true);

    path.value = "./Log/$yearName/$monthName/$dayName/$fileName.txt";

    File file = File(path.value);
    //String firstRow = "$fileName시 로그";

    List<dynamic> logData = [];
    logData.addAll(Get.find<LogController>().loglist);
    print('logData:' + '$logData');
    String addLogFile = logData.join();

    print("log file in");
    String intergrationColumn = addLogFile;

    return file.writeAsString(intergrationColumn);
  }
}
