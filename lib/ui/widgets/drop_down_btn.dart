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
        value: 0,
        onChanged: (int? value) {
          // setState(() {
          // index = value!;
          // });
        },
        items: [
          DropdownMenuItem(
            value: 0,
            child: Text('ALL'),
          ),
          DropdownMenuItem(
            value: 1,
            child: Text('OES'),
          ),
          DropdownMenuItem(
            value: 2,
            child: Text('VI'),
          ),
          DropdownMenuItem(
            value: 3,
            child: Text('CUSTOM 1'),
          ),
          DropdownMenuItem(
            value: 4,
            child: Text('+'),
          ),
        ],
      ),
    );
  }
}
