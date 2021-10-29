import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetBtn extends StatefulWidget {
  const ResetBtn({Key? key}) : super(key: key);

  @override
  State<ResetBtn> createState() => _RefreshBtnState();
}

class _RefreshBtnState extends State<ResetBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton.icon(
        onPressed: () {
          print('reset!!');
          // Get.toNamed('/');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => super.widget));
        },
        icon: Icon(Icons.refresh),
        label: Text('Reset'),
      ),
    );
  }
}
