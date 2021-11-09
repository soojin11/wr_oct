import 'package:get/get.dart';

enum DropDown { ALL, OES, VI, CUSTOM, ADD }

extension DropDownExtension on DropDown {
  String get name {
    switch (this) {
      case DropDown.ALL:
        return ' 기본(ALL)메뉴';
      case DropDown.OES:
        return ' OES메뉴';
      case DropDown.VI:
        return ' VI메뉴';
      case DropDown.CUSTOM:
        return ' CUSTOM메뉴';
      case DropDown.ADD:
        return ' 메뉴 추가';
    }
  }
}

class DropDownController extends GetxController {
  //여기서 드롭다운의 상태관리 해 줄 것.
  //value,currentItem값 상태관리할것.
  Rx<DropDown> currentItem = DropDown.ALL.obs;
  void changeDropDown(int? itemIndex) {
    var selectedItem =
        DropDown.values.where((menu) => menu.index == itemIndex).first;
    currentItem(selectedItem);
  }
}
