import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RefreshBtn extends StatefulWidget {
  const RefreshBtn({Key? key}) : super(key: key);

  @override
  State<RefreshBtn> createState() => _RefreshBtnState();
}

class _RefreshBtnState extends State<RefreshBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton.icon(
        onPressed: () {
          print('refresh!!');
          Get.offAll('/');
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (BuildContext context) => widget));
        },
        icon: Icon(Icons.refresh),
        label: Text('Reset'),
      ),
    );
  }
}
