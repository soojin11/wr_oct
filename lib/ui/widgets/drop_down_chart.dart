import 'package:flutter/material.dart';
import 'package:wr_ui/ui/widgets/drop_down_btn.dart';

class CahrtDropDown extends StatelessWidget {
//겟엑스로 셋스테이트->
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropDownBtn(),
        Expanded(
            child: Center(
          child: Text('0 page'),
        ))
      ],
    );
  }
}
