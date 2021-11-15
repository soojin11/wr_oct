import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class StartStop extends StatelessWidget {
  const StartStop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      minWidth: 50,
      minHeight: 20,
      cornerRadius: 10.0,
      activeBgColors: [
        [Colors.green[800]!],
        [Colors.red[800]!]
      ],
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.white,
      initialLabelIndex: 1,
      totalSwitches: 2,
      labels: ['Start', 'Stop'],
      radiusStyle: true,
      onToggle: (index) {
        if (index == 1) {
          print('스탑');
        } else {
          print('스타트');
        }
      },
    );
  }
}
