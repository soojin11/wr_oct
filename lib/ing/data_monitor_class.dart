import 'dart:ffi';

import 'dart:io';

typedef _OpenAllSpectrometersC = Uint32 Function();
typedef _OpenAllSpectrometersDart = int Function();

class FFIOCR {
  final DynamicLibrary dylib;
  static final _instance = FFIOCR._();

  FFIOCR._()
      : dylib = DynamicLibrary.open(
            Platform.script.resolve('./OCR.dll').toFilePath());

  factory FFIOCR() => _instance;

  Function get OpenAllSpectrometersFunc =>
      dylib.lookupFunction<_OpenAllSpectrometersC, _OpenAllSpectrometersDart>(
          'OpenAllSpectrometers');
  int OpenAllSpectrometers() => OpenAllSpectrometersFunc();
}
