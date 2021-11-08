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
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.alarm),
            Text(
              DateFormat('yyyy/MM/dd \n hh:mm:ss').format(DateTime.now()),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}