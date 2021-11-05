import 'package:get/get.dart';

enum SettingDropDown { DEVICE, CHART }

extension DropDownExtension on SettingDropDown {
  String get name {
    switch (this) {
      case SettingDropDown.DEVICE:
        return 'Go Device Setting';
      case SettingDropDown.CHART:
        return 'Go Chart Setting';
    }
  }
}

class SettingDropDownController extends GetxController {
  //여기서 드롭다운의 상태관리 해 줄 것.
  //value,currentItem값 상태관리할것.
  Rx<SettingDropDown> currentItem = SettingDropDown.DEVICE.obs;
  void changeDropDown(int? itemIndex) {
    var selectedItem =
        SettingDropDown.values.where((menu) => menu.index == itemIndex).first;
    currentItem(selectedItem);
  }
}
