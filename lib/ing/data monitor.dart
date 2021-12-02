import 'dart:ffi';

import 'package:flutter/material.dart';

final DynamicLibrary wgsFunction = DynamicLibrary.open("wgsFunction2.dll");
final DynamicLibrary wgsTest = DynamicLibrary.open("wgs.dll");

class DataMonitorTest extends StatelessWidget {
  DataMonitorTest({Key? key}) : super(key: key);
  late int Function() ocrStart;
  late int Function(int a) getBoxcarWidth;
  late void Function(int a) testtest;
  late void Function(int a) setmsg;
  late void Function(int a) test;
  late void Function(int a) getMPM2000Component;
  late int Function() OpenAllSpectrometers;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        // ocrStart = wgsTest
        //     .lookup<NativeFunction<Int8 Function()>>('OCR_Start')
        //     .asFunction();
        // int aa = ocrStart();
        // print('ocrStart??' + '$aa');
        // setmsg = wgsTest
        //     .lookup<NativeFunction<Void Function(Int32)>>('setmsg')
        //     .asFunction();
        // setmsg(2);
        // print('setmsg??' + '${setmsg.toString()}');
        // test = wgsTest
        //     .lookup<NativeFunction<Void Function(Int32)>>('test')
        //     .asFunction();
        // test(1);
        // OpenAllSpectrometers = wgsTest
        //     .lookup<NativeFunction<Int8 Function()>>('OpenAllSpectrometers')
        //     .asFunction();
        // OpenAllSpectrometers();
        // print('OpenAllSpectrometers' + '${OpenAllSpectrometers.toString()}');
        // getMPM2000Component = wgsTest
        // .lookup<NativeFunction<Void Function(Int32)>>('GetMPM2000Component')
        // .asFunction();
        // getMPM2000Component(2);
        // ocrStart = wgsTest
        //     .lookup<NativeFunction<Int8 Function()>>('OCR_Start')
        //     .asFunction();
        // ocrStart();
        // setmsg = wgsTest
        //     .lookup<NativeFunction<Void Function(Int32)>>('setmsg')
        //     .asFunction();
        // setmsg(2);
        // test = wgsTest
        //     .lookup<NativeFunction<Void Function(Int32)>>('test')
        //     .asFunction();
        // test(1);
      },
      child: Text('dll test'),
    );
  }
}
