import 'dart:io';

import 'package:get/get.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';
import 'package:ini/ini.dart';

class iniRead extends GetxController {
  static iniRead get to => Get.find();
  // Config iniData = new Config();
  Config? config;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  //ini파일에서 불러와서 세팅다이얼로그에 값 세팅
  void allocateValueToSetting() async {
    //디바이스세팅
    //deviceName
    // print(object)
    print(
        'SDASDASDSA:${Get.find<doConfigController>().config.items('DEFALUTS')}');
    //interval
    //unit
    //차트세팅
    //chartName
    //chartColor
    //chartTheme
    //seriesType
    //scaleValue
  }
  //ini파일에서 불러와서 세팅다이얼로그에 값 세팅
//F20211029-011브랜치 테스
}
