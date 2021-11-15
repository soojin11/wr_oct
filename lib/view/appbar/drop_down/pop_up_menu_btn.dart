import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/drop_down_controller.dart';
import 'package:wr_ui/model/const/style/pallette.dart';

class PopUpMenu extends GetView<DropDownController> {
  const PopUpMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        tooltip: '차트종류를 선택해주세요.',
        padding: EdgeInsets.all(10),
        shape: ShapeBorder.lerp(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            0.5),
        onSelected: (int value) {
          controller.changeDropDown(value);
        },

        //컬러는 임시로해놓음
        offset: Offset(-20, 43),
        elevation: 10,
        itemBuilder: (BuildContext context) {
          return DropDown.values
              .map(
                (menu) => PopupMenuItem(
                  value: menu.index,
                  child: Text(
                    menu.name,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              )
              .toList();
        },
        child: Obx(() => Expanded(
              child: Center(
                child: Container(
                  width: 150,
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: wrColors.wrPrimary),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(controller.currentItem.value.name),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
