import 'package:flutter/material.dart';
import 'package:wr_ui/style/text.dart';

class RecentRecipeName extends StatelessWidget {
  const RecentRecipeName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Text(
        'ExampleRecipeName',
        style: WrText.WrLeadingFont,
      ),
    );
  }
}
