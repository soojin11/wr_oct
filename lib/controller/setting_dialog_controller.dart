import 'package:get/get.dart';

enum Setting { DEVICE, CHART }

extension SettingExtension on Setting {
  String get name {
    switch (this) {
      case Setting.DEVICE:
        return '디바이스세팅';
      case Setting.CHART:
        return '차트세팅';
    }
  }
}

class SettingController extends GetxController {
  Rx<Setting> currentRadioBtnItem = Setting.DEVICE.obs;
  void changeSettingRadio(int? radioId) {
    var selectedRadioBtnItem =
        Setting.values.where((radio) => radio.index == radioId).first;
    currentRadioBtnItem(selectedRadioBtnItem);
  }
}
