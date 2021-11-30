// ignore: import_of_legacy_library_into_null_safe
import 'package:dllimport_gen/annotations.dart';
import 'package:dllimport_gen/dll_import.dart';

import 'package:get/get.dart';

@DllImport('OCR.dll')
abstract class OCR {
  LONG OpenAllSpectrometers();
}

class DataMonitorCtrl extends GetxController {
// var ocr=

}
