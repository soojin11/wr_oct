// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:wr_ui/ing/data%20monitor.dart';
// import 'package:wr_ui/view/chart/oes_chart.dart';

// final DynamicLibrary wgsFunction = DynamicLibrary.open("WGSFunction.dll");

// class DataMonitoring extends StatelessWidget {
//   DataMonitoring({Key? key}) : super(key: key);
//   ///////////app start

//   late int Function() ocrStart;
//   late int Function(int a) getBoxcarWidth;
//   late void Function(int a) testtest;
//   late void Function(int a) setmsg;
//   late void Function(int a) test;
//   late void Function() getMPM2000Component;
//   late int Function() openAllSpectrometers;
//   late int Function(int spectrometerIndex, int slot, double val)
//       setNonlinearityCofficient;
//   late void Function() closeAll;
//   late void Function(int portName) mpmStart;
//   late int Function(int tf) mpmOpen;
//   late void Function() mpmClose;
//   late double Function() GetFormatedSpectrum;
//   late int Function(int spectrometerIndex, int integrationTime)
//       setIntegrationTime;

//   Future<void> init() async {
//     ocrStart = wgsFunction
//         .lookup<NativeFunction<Int8 Function()>>('OCR_Start')
//         .asFunction();
//     int ocrs = ocrStart();
//     print('ocrStart??' + ' ${ocrs}');

//     mpmStart = wgsFunction
//         .lookup<NativeFunction<Void Function(Int32)>>('MPMStart')
//         .asFunction();
//     // mpmStart(1);
//     // print('mpmStart' + '$mpmStart');
//     mpmOpen = wgsFunction
//         .lookup<NativeFunction<Int8 Function(Int32)>>('MPMOpen')
//         .asFunction();
//     // int dd = mpmOpen(1);
//     // int dd = mpmOpen(1);
//     // print('$dd');
//     // mpmOpen(1);
//     mpmClose = wgsFunction
//         .lookup<NativeFunction<Void Function()>>('MPMClose')
//         .asFunction();
//     // mpmClose();
//     closeAll = wgsFunction
//         .lookup<NativeFunction<Void Function()>>('CloseAll')
//         .asFunction();
//     closeAll();
//     openAllSpectrometers = wgsFunction
//         .lookup<NativeFunction<Int32 Function()>>('OpenAllSpectrometers')
//         .asFunction();
//     int bb = openAllSpectrometers();

//     setIntegrationTime = wgsFunction
//         .lookup<NativeFunction<Int32 Function(Int32, Int32)>>(
//             'SetIntegrationTime')
//         .asFunction();
//     bb = setIntegrationTime(6, 300);

//     // setIntegrationTime = wgsFunction
//     //     .lookup<NativeFunction<Int8 Function(Int32, Int32)>>('SetIntegrationTime')
//     //     .asFunction();
//     // setIntegrationTime(6, 200);

//     //////////app start
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 2,
//       height: 2,
//       child: Center(
//         child: CustomPaint(
//           painter: OpenPainter(),
//         ),
//       ),
//     );
//   }
// }

// class OpenPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint1 = Paint()
//       ..color = !Get.find<OesController>().inactiveBtn.value
//           ? Color(0xFFE91414)
//           : Color(0xFF14E942)
//       ..style = PaintingStyle.fill;
//     //a circle
//     canvas.drawCircle(Offset(1, 1), 10, paint1);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }
