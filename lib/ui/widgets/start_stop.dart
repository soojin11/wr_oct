import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class StartStop extends StatelessWidget {
  const StartStop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      minWidth: 90.0,
      cornerRadius: 20.0,
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
        print('switched to: $index');
      },
    );
  }
}

test() {}
