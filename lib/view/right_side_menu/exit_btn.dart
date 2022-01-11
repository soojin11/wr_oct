import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/button.dart';
import 'package:wr_ui/controller/viz_ctrl.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/log_screen.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';

import 'csv_creator.dart';

//////////21.12.09 수진//////////////
class ExitBtn extends StatelessWidget {
  const ExitBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RightButton(
      text: 'Exit',
      icon: Icons.exit_to_app,
      primary: wrColors.wrPrimary,
      onPressed: () {
        Get.find<runErrorStatusController>().connect.value
            ?
            /////////////////true 일 때////////////////////////
            runningExit(context)
            :
            //////////////false일 때//////////////////
            completelyExit(context);
      },
    );
  }
}

Future<String?> runningExit(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('측정 중 입니다.'),
      content: const Text('측정을 중지 하시겠습니까?'),
      actions: <Widget>[
        TextButton(
          child: const Text(
            '취소',
            style: TextStyle(color: wrColors.wrPrimary),
          ),
          onPressed: () => Navigator.pop(context, '취소'),
        ),
        TextButton(
          child: const Text(
            '예',
            style: TextStyle(color: wrColors.wrPrimary),
          ),
          onPressed: () {
            Get.find<OesController>().timer?.cancel();
            VizCtrl.to.timer.cancel();
            Get.find<runErrorStatusController>().statusColor.value = Colors.red;
            Get.find<OesController>().inactiveBtn.value = false;
            Get.find<CsvController>().csvSaveInit.value = false;
            Get.find<CsvController>().csvSaveData.value = false;
            if (Get.find<iniController>().sim.value == 0) {
              mpmSetChannel(0);
            }
            completelyExit(context);
          },
        ),
      ],
    ),
  );
}

Future<String?> completelyExit(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('종료하시겠습니까?'),
      content: const Text('프로그램이 완전히 종료됩니다.'),
      actions: <Widget>[
        TextButton(
            child: const Text(
              '예',
              style: TextStyle(color: wrColors.wrPrimary),
            ),
            onPressed: () {
              if (Get.find<iniController>().sim.value == 0) {
                mpmSetChannel(0);
                closeAll();
              }
              Get.find<LogListController>().cExit();
              VizCtrl.to.vizChannel[0].port.close();
              showDialog(
                  context: context,
                  builder: (context) {
                    //종료시간 짧게 넣음
                    Future.delayed(Duration(milliseconds: 300), () {
                      exit(0);
                    });
                    return AlertDialog(
                      title: Text('종료됩니다.'),
                    );
                  });
            }),
        TextButton(
          child: const Text(
            '취소',
            style: TextStyle(color: wrColors.wrPrimary),
          ),
          onPressed: () =>
              Get.offAll(Home(), transition: Transition.noTransition),
        ),
      ],
    ),
  );
}
