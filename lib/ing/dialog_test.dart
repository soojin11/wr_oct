import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/setting_content.dart';
import 'package:wr_ui/view/appbar/actions/setting/setting_menu_final.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';

Future displayDialog(BuildContext context) async {
  TextEditingController _textFieldController = TextEditingController();
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Settings',
            style: TextStyle(
              fontSize: 20,
              color: wrColors.wrPrimary,
            ),
          ),

          content: Form(
            // key: Get.find<SettingContnet>().key,
            child: Column(
              children: [
                Divider(
                  thickness: 0.3,
                  color: Colors.grey[700],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    children: [
                      Text(
                        'Device Setting',
                        style: TextStyle(
                          fontSize: 20,
                          color: wrColors.wrPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.label),
                      labelText: 'measureStartAtProgStart',
                    ),
                    onChanged: (String value) {
                      // setState(() {
                      //   deviceName = value;
                      // });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    initialValue: Get.find<iniControllerWithReactive>()
                        .ExposureTime
                        .value,
                    decoration: InputDecoration(
                      icon: Icon(Icons.label),
                      labelText: 'Exposure Time',
                      hintText: 'milliseconds',
                    ),
                    onSaved: (val) {
                      // Get.find<SettingController>()
                      //     .ExposureTime
                      //     .value = savedValue.toString();
                      //val(텍스트폼에 친거)->
                      Get.find<iniControllerWithReactive>().ExposureTime.value =
                          val.toString();
                      // setState(() {
                      // ExposureTime = val;
                      // });
                      //   print(
                      //       ' Setting창에서 저장 된 ExposureTime=>"${Get.find<iniControllerWithReactive>().ExposureTime.value}"  "${Get.find<SettingController>().ExposureTime.value}"');
                      // },
                      // onSaved: (savedValue) {
                      //   Get.find<SettingController>()
                      //       .ExposureTime
                      //       .value = savedValue.toString();

                      //   Get.find<iniControllerWithReactive>()
                      //       .ExposureTime
                      //       .value = savedValue.toString();
                      //   setState(() {
                      //     ExposureTime = savedValue.toString();
                      //   });
                      //   print(
                      //       ' Setting창에서 저장 된 ExposureTime=>"${Get.find<iniControllerWithReactive>().ExposureTime.value}"');
                    },
                  ),
                ),
              ],
            ),
          ),

          // TextField(
          // controller: _textFieldController,
          // textInputAction: TextInputAction.go,
          // keyboardType: TextInputType.numberWithOptions(),
          // decoration: InputDecoration(
          // hintText:
          // Get.find<iniControllerWithReactive>().ExposureTime.value),
          // ),
          actions: [
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
