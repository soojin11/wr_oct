// ignore: import_of_legacy_library_into_null_safe
import 'dart:ffi';

import 'package:dllimport_gen/dll_import.dart';
import 'package:dllimport_gen/annotations.dart';
import 'package:dllimport_gen/builder.dart';
import 'package:dllimport_gen/dll_import.dart';
import 'package:dllimport_gen/winapi_types.dart';
import 'package:get/get.dart';

class DataMonitorCtrl extends GetxController {}

// class FFIUser32 {
//   final DynamicLibrary _dylib;
//   static final _instance = FFIUser32._();

//   FFIUser32._() : _dylib = DynamicLibrary.open('user32.dll');

//   factory FFIUser32() => _instance;

//   Function get _SetCursorPosFunc =>
//       _dylib.lookupFunction<_SetCursorPosC, _SetCursorPosDart>('SetCursorPos');
//   int SetCursorPos(int X, int Y) => _SetCursorPosFunc(X, Y);
// }

////////////////
class FFIOcr {
  final DynamicLibrary _dylib;
  static final _instance = FFIOcr._();

  FFIOcr._() : _dylib = DynamicLibrary.open('OCR.dll');

  factory FFIOcr() => _instance;

  Function get _Open => _dylib.lookupFunction('SetCursorPos');
  int Open() => _Open();
}

@DllImport('OCR.dll')
abstract class OCR {
  int Open();
}

void main() {
  print('$OCR');
  var ocr = FFIOcr();
  var success = ocr.Open() != 0;
  if (!success) {
    print('success=>${ocr.Open().toString()}');
  }
}
