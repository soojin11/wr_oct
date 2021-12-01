import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// final DynamicLibrary FT232H = Platform.isWindows
//     ? DynamicLibrary.open('WGSCOM.dll')
//     : DynamicLibrary.process();

// final DynamicLibrary FT232Hfunc = Platform.isWindows
//     ? DynamicLibrary.open('WGSCOM.dll')
//     : DynamicLibrary.process();
final DynamicLibrary FT232H = DynamicLibrary.open('ClassLibrary1.dll');
// final DynamicLibrary WGSFunction = DynamicLibrary.open('WGSFunction.dll');

class DataMonitor extends GetxController {
  late void Function(Pointer<Int16> GetMPM2000Component) GetMPM2000Component;
  late int Function(int spectrometerIndex) GetMaxScansToAverage;
  late void Function(int a) Close;

  Future<void> init() async {
    // GetMPM2000Component = FT232H
    //     .lookup<NativeFunction<Void Function(Pointer<Int16>)>>(
    //         'GetMPM2000Component')
    //     .asFunction();
    // print('GetMPM2000Component init');

    // Close = FT232H
    //     .lookup<NativeFunction<Void Function(Int32)>>('Close')
    //     .asFunction();
    // print('Close init');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.redAccent)),
      child: Text(''),
    );
  }
}
