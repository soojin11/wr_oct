// import 'dart:io';
// import 'package:csv/csv.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import 'Logs.dart';
// import 'viz_chart.dart';
// import 'save_logs.dart';

// class CsvController extends GetxController {
//   static CsvController get to => Get.find();
//   RxString path = ''.obs;
//   RxBool fileSave = false.obs;
//   // RxDouble dataOne = 0.0.obs;
//   // RxDouble dataTwo = 0.0.obs;
//   // RxDouble xValue = 0.0.obs;
//   // RxBool chartStart = false.obs;
//   // RxBool chartStope = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//   }

//   Future<File> csvSave() async {
//     DateTime current = DateTime.now();
//     final String fileName = '${DateFormat('yyyyMMdd_hhmmss').format(current)}';
//     print('$fileName');
//     List<dynamic> firstData = [];
//     List<List<dynamic>> addFirstData = [];
//     File file = File(path.value);

//     // if (Get.find<LogController>().fileSave.value) {
//     //   //이부분을 뭔가 바꿔야되는데
//     //   //여기가 데이터 넣은거 이거는 oes 데이터 쓸 때 사용하깅
//     //   Get.find<ChartController>().chartData.forEach((v) {
//     //     firstData.add(v.num);
//     //   });
//     //   //firstData.addAll(Get.find<ChartController>().chartData);
//     // }

//     addFirstData.add(firstData);
//     String csv = const ListToCsvConverter().convert(addFirstData) + '\n';
//     return file.writeAsString(csv, mode: FileMode.append);
//   }

//   Future<File> csvSaveInit() async {
//     DateTime current = DateTime.now();
//     print("csv save");
//     final String fileName = DateFormat('yyyyMMdd-HHmmss').format(current);
//     final String streamDateTime =
//         DateFormat('yyyy/MM/dd HH:mm:ss').format(current);
//     await Directory('datafiles').create();
//     path.value = "./datafiles/$fileName.csv";
//     String startTime = streamDateTime;
//     File file = File(path.value);
//     String firstRow = "FileFormat:1";
//     String secondRow = "HWType:SPdbUSBm";
//     String thirdRow = "Start Time : $startTime";
//     String fourthRowFirst = "Intergration Time:";
//     String fourthRowSecond = "Interval:";

//     // String s =
//     //     Get.find<ChartController>().chartData.toString().splitMapJoin(',');

//     // List<String> addtime = [];

//     // Get.find<ChartController>().chartData.forEach((e) {
//     //   addtime.add(e.time.toString());
//     // });
//     // String timeVal = addtime.join('\n');

// // List<String> timeData = [];
// // timeData.add(fileName);
// // String qwe = timeData.join('\n');

//     List<int> addData = [];
//     //addData.add(fileName);
//     Get.find<ChartController>().chartData.forEach((e) {
//       addData.add(e.num);

//     });

//     String qwe =  addData.join('\n'); //viz 데이터

//     // String oes = ss.join(',') + s;
//     // String s = Get.find<ChartController>().chartData[0].value.tableX.join(',');
//     // List<String> ss = [];
//     // // print(
//     // //     'csvSave rwls length ${Get.find<RangeWaveLengthController>().rwls.length}');
//     // Get.find<ChartController>().rwls.forEach((e) {
//     //   ss.add('${e.value.vStart}~${e.value.vEnd}');
//     // });
//     // String hemos = '';
//     // if (Get.find<ChartController>().modeHemos.value) {
//     //   hemos = 'Vpp' + ',' + 'Dcpr' + ',';
//     // }

//     // String addTime =
//     //     Get.find<ChartController>().chartSet[0].value.tableVal.join(',');
//     // List<String> TimeTable = [];
//     // Get.find<ChartController>().chartSet.forEach((v) {
//     //   TimeTable.add('${v.value.tStart}~${v.value.tEnd}');
//     // });
//     // String viz = TimeTable.join(',') + ',' + addTime;

//     print("csv 파일");
//     String intergrationColumn = firstRow +
//             '\n' + //다음 횡
//             secondRow +
//             '\n' +
//             thirdRow +
//             '\n' +
//             fourthRowFirst +
//             ',' + //다음 열
//             fourthRowSecond +
//             // ',' +
//             // fourthRowThird +
//             '\n' +

//             "VIZ" +
//                 '\n'
//          +qwe
//         //timeVal + ',' +

//         // //oes
//         //Get.find<ChartController>().chartData.toString();
//         ;
//     return file.writeAsString(intergrationColumn);
//   }
// }

// class CSVButton extends StatelessWidget {
//   Future<void> updateCSV() async {
//     Get.find<CsvController>().csvSave();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           child: OutlinedButton(
//               onPressed: () async {
//                 await Get.find<CsvController>().csvSaveInit();
//                 Get.find<CsvController>().fileSave.value = true; //csv안에 데이터 넣기

//                 Get.find<LogListController>().clickedSave(); //화면에 로그 뜨는거
//                 Get.find<LogController>().loglist.add(
//                     '${DateTime.now()} Start Saving Data' +
//                         '\n'); //로그 안에 내용 저장
//                         //
//                 Get.find<LogController>().logSaveInit(); //로그 초기화
//                 Get.find<LogController>().fileSave.value = true; //로그 파일 저장
//               },
//               child: Text("Save Start")),
//         ),
//         Container(
//             child: OutlinedButton(
//                 onPressed: () {
//                   Get.find<CsvController>().fileSave.value = false;
//                   Get.find<LogListController>().clickedSaveDone();
//                   Get.find<LogController>().loglist.add(
//                       '${DateTime.now()} Stop Saving Data' +
//                           '\n');
//                 },
//                 child: Text("Save Stop")))
//       ],
//     );
//   }
// }
import 'dart:async';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wr_ui/model/pallette.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';

import 'log_screen.dart';

class CSVButton extends StatelessWidget {
  Future<void> updaeteCSV() async {
    Get.find<CsvController>().csvSave();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        ElevatedButton(
          onPressed: () async {
            await Get.find<CsvController>().csvSaveInit();
            Get.find<CsvController>().fileSave.value = true;
            Get.find<LogListController>().startCsv();
          },
          child: Container(
            width: 200,
            child: Center(
              child: Text(
                "Save Start",
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: wrColors.wrPrimary,
          ),
        ),
        SizedBox(height: 30),
        ElevatedButton(
          onPressed: () async {
            Get.find<CsvController>().fileSave.value = false;
            Get.find<LogListController>().stopCsv();
          },
          child: Container(
            width: 200,
            child: Center(
              child: Text(
                "Save Stop",
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: wrColors.wrPrimary,
          ),
        ),
        // SizedBox(height: 50),
        // Row(mainAxisAlignment: MainAxisAlignment.center,
        // children: [
        //   OutlinedButton(onPressed:(){Get.find<OesController>().timer = Timer.periodic(
        //           Duration(milliseconds: 100), Get.find<OesController>().updateDataSource);
        //           Get.find<OesController>().oesData;
        //           Get.find<VizController>().timer = Timer.periodic(
        //           Duration(milliseconds: 100), Get.find<VizController>().updateDataSource);
        //           Get.find<LogListController>().clickedStart();
        //           },
        //           child: Text('All Start')),
        //           OutlinedButton(
        //             onPressed: (){Get.find<VizController>().timer.cancel();
        //             Get.find<OesController>().timer.cancel();
        //             Get.find<LogListController>().clickedStop();},
        //             child: Text('All Stop'))],)
      ],
    );
  }
}

class CsvController extends GetxController {
  static CsvController get to => Get.find();
  RxString path = ''.obs;
  RxBool fileSave = false.obs;
  RxBool inactiveBtn = false.obs;
  RxDouble yVal = 0.0.obs;
  RxList vizYVal = RxList.empty();
  @override
  void onInit() {
    super.onInit();
  }

  Future<File> csvSave() async {
    DateTime current = DateTime.now();
    String ms = DateTime.now().millisecondsSinceEpoch.toString();
    int msLength = ms.length;
    int third = int.parse(ms.substring(msLength - 3, msLength));
    String fileName = '${DateFormat('HH:mm:ss').format(current)}.$third';
    //print('$fileName');
    File file = File(path.value);
//     List<dynamic> initData = ["FileFormat:1","HWType:SPdbUSBm","Start Time : $startTime","Intergration Time:","Interval:"];

// List<int> timeData = [];
// List<int> rangeData = [];
// List<int> oesVal = [];
//     if(Get.find<CsvController>().fileSave.value){
//       Get.find<VizController>().chartData.forEach((e) {firstData.add(e.num);});
//     Get.find<VizController>().chartData.forEach((e) {timeData.add(e.time);});
//     Get.find<OesController>().oesData.forEach((v) {rangeData.add(v.range); });
//     Get.find<OesController>().oesData.forEach((v) {oesVal.add(v.num);});
//     }

//     String qwe = initData.join('\n')+'\n'+"VIZ"+','+rangeData.join(',')+'\n'+firstData.join('\n') + ','+oesVal.join(',');
//     return file.writeAsString(qwe);

    List<dynamic> firstData = [];
    List<List<dynamic>> addFirstData = [];
    firstData.add(fileName);
    if (Get.find<CsvController>().fileSave.value) {
      firstData.add(yVal.value);
      Get.find<OesController>().oesData.forEach((v) {
        firstData.add(v.num);
      });
    }

    addFirstData.add(firstData);
    String csv = const ListToCsvConverter().convert(addFirstData) + '\n';
    return file.writeAsString(csv, mode: FileMode.append);

//return file.writeAsString("${vizData.join('\n')},${oesData.join(',')}" );
  }

  Future<File> csvSaveInit() async {
    DateTime current = DateTime.now();
    //print("csv save");
    final String fileName = DateFormat('yyyyMMdd-HHmmss').format(current);
    final String streamDateTime =
        DateFormat('yyyy/MM/dd HH:mm:ss').format(current);
    await Directory('datafiles').create();
    path.value = "./datafiles/$fileName.csv";
    String startTime = streamDateTime;
    File file = File(path.value);

    List<dynamic> initData = [
      "FileFormat:1",
      "HWType:SPdbUSBm",
      "Start Time : $startTime",
      "Intergration Time:",
      "Interval:"
    ];
    //print("exists in");

    List<int> rangeData = [];
    Get.find<OesController>().oesData.forEach((v) {
      rangeData.add(v.range);
    });

    String intergrationColumn = initData.join('\n') +
        '\n' +
        "Time" +
        ',' +
        "VIZ_1" +
        ',' +
        rangeData.join(',') +
        '\n';

    return file.writeAsString(intergrationColumn);
  }
}
