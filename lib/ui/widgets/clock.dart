import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Clock extends StatelessWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(Duration(seconds: 1)),
      builder: (context, snapshot) {
        return Column(
          children: [
            Text(
              DateFormat('yyyy/MM/dd').format(DateTime.now()),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              DateFormat('hh:mm:ss').format(DateTime.now()),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
