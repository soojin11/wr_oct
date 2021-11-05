import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/drop_down_controller.dart';

class DropDownBtn extends GetView<DropDownController> {
  //겟엑스로 셋스테이트->GetView<DropDownController> 하니까 스테이트풀 안써도됨
  const DropDownBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButton(
        value: controller.currentItem.value.index,
        onChanged: (int? value) {
          // setState(() {
          // index = value!;
          // });
          controller.changeDropDown(value!);
        },
        items: DropDown.values
            .map(
              (menu) => DropdownMenuItem(
                value: menu.index,
                child: Text(
                  menu.name,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
