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
        return Container(
          child: Column(
            children: [
              Text(
                DateFormat('\n yyyy/MM/dd \n HH:mm:ss').format(DateTime.now()),
                style: WrClockText.WrLeadingFont,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
