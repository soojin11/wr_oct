import 'package:flutter/material.dart';
import 'package:wr_ui/ing/dialog_test.dart';
import 'package:wr_ui/model/const/style/text.dart';

class dialogBtn extends StatelessWidget {
  const dialogBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton.icon(
        onPressed: () {
          displayDialog(context);
        },
        icon: Icon(Icons.settings),
        label: Text(
          'Setting',
          style: WrText.WrLeadingFont,
        ),
      ),
    );
  }
}
