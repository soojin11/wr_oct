import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/setting_drop_down_controller.dart';

class SettingPopUpMenu extends GetView<SettingDropDownController> {
  const SettingPopUpMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
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
        color: Colors.blueGrey,
        //컬러는 임시로해놓음
        offset: Offset(0, 40),
        elevation: 0,
        itemBuilder: (BuildContext context) {
          return SettingDropDown.values
              .map(
                (menu) => PopupMenuItem(
                  value: menu.index,
                  child: Text(menu.name),
                ),
              )
              .toList();
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Icon(Icons.settings),
              SizedBox(
                width: 10,
              ),
              Text('Setting')
            ],
          ),
        ));
  }
}
