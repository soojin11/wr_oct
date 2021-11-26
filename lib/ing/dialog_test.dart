import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/setting_content.dart';
import 'package:wr_ui/view/appbar/actions/setting/setting_menu_final.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';

class settingDialogController extends GetxController {
  //////measureStartAtProgStart가 0일 때, 프로그램 시작 시, 수동으로 측정시작,
  //////measureStartAtProgStart가 1일 때, 프로그램 시작 시, 자동으로 측정시작,
  RxString measureStartAtProgStart = '1'.obs;

//OESsimulation&OESchannelCount =>위에 조건문에 넣을 거,기능명세서에서 device all check
  RxInt OESsimulation = 0.obs;
  RxInt OESchannelCount = 8.obs;

  ///currentDirectoryAutoSave 0이면 유저가 파일이름 위치 설정하는 창 띄우기
  ///currentDirectoryAutoSave 1이면 원래저장경로(CSVsavePath)에 저장되기
  RxInt currentDirectoryAutoSave = 0.obs;
  RxString CSVsavePath = './datafiles/'.obs;
  //saveFromStartSignal 0이면 동작 없음
  //saveFromStartSignal 1이면 측정 시작점~측정종료점까지 데이터들 저장.
  RxInt saveFromStartSignal = 0.obs;
  //dataViewStartFromMoreValueOES=>oes측정값이 몇 초과 일 때부터 그래프에 표시
  RxDouble dataViewStartFromMoreValueOES = 0.0.obs;
  RxDouble dataViewStartFromMoreValuesVI = 0.0.obs;
  RxString exposureTime = '100'.obs;
  RxInt delayTime = 0.obs;
  RxInt currentval = 1.obs;
}

Future displayDialog(BuildContext context) async {
  TextEditingController _textFieldController = TextEditingController();
  int val = 1;
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
                    initialValue: Get.find<iniControllerWithReactive>()
                        .measureStartAtProgStart
                        .value,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.label),
                      labelText: 'measureStartAtProgStart',
                    ),
                    onChanged: (String value) {
                      // setState(() {
                      //   deviceName = value;
                      // });
                      Get.find<iniControllerWithReactive>()
                          .measureStartAtProgStart
                          .value = value;
                    },
                  ),
                ),
                //자동측정인지 수동측정인지 정하기
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setstate) {
                  int selectedRadio = 0;
                  return Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: Text('auto'),
                          value: Get.find<settingDialogController>()
                              .currentval
                              .value,
                          groupValue: selectedRadio,
                          onChanged: (value) {
                            setstate(() => selectedRadio = 0);

                            Get.find<settingDialogController>()
                                .measureStartAtProgStart
                                .value = value.toString();
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: Text('manual'),
                          value: Get.find<settingDialogController>()
                              .currentval
                              .value,
                          groupValue: selectedRadio,
                          onChanged: (value) {
                            setstate(() => selectedRadio = 1);
                            Get.find<settingDialogController>()
                                .currentval
                                .value = 1;
                            Get.find<settingDialogController>()
                                .measureStartAtProgStart
                                .value = value.toString();
                          },
                        ),
                      ),
                    ],
                  );
                }),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    initialValue: Get.find<iniControllerWithReactive>()
                        .measureStartAtProgStart
                        .value,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.label),
                      labelText: 'select measure mode',
                    ),
                    onChanged: (String value) {
                      // setState(() {
                      //   deviceName = value;
                      // });
                      Get.find<iniControllerWithReactive>()
                          .measureStartAtProgStart
                          .value = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    initialValue: Get.find<iniControllerWithReactive>()
                        .exposureTime
                        .value,
                    decoration: InputDecoration(
                      icon: Icon(Icons.label),
                      labelText: 'Exposure Time',
                      hintText: 'milliseconds',
                    ),
                    onSaved: (val) {
                      Get.find<iniControllerWithReactive>().exposureTime.value =
                          val.toString();

                      print(
                          ' Setting창에서 저장 된 exposureTime=>"${Get.find<iniControllerWithReactive>().exposureTime.value}"  "${Get.find<SettingController>().exposureTime.value}"');
                    },
                  ),
                ),
              ],
            ),
          ),
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
