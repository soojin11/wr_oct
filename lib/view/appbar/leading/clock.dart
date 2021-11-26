import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wr_ui/model/const/style/text.dart';

class Clock extends StatelessWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(Duration(seconds: 1)),
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 6,
            right: 6,
            top: 4,
          ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('yyyy/MM/dd').format(DateTime.now()),
                  style: WrText.WrLeadingFont,
                ),
                Text(
                  DateFormat('hh:mm:ss').format(DateTime.now()),
                  style: WrText.WrLeadingFont,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
