import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/ing/dialog_test.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/model/const/style/text.dart';

class dialogBtn extends GetView<settingDialogController> {
  const dialogBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton.icon(
        onPressed: () {
          displayDialog(context);
        },
        icon: Icon(
          Icons.settings,
          color: wrColors.white,
        ),
        label: Text(
          'Setting',
          style: WrText.WrLeadingFont,
        ),
      ),
    );
  }
}
