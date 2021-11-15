import 'package:flutter/material.dart';
import 'package:wr_ui/model/const/style/pallette.dart';

class SettingContnet extends StatefulWidget {
  const SettingContnet({Key? key}) : super(key: key);

  @override
  _SettingContnetState createState() => _SettingContnetState();
}

class _SettingContnetState extends State<SettingContnet> {
  String radioBtnItem = 'Device';
  int id = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Radio(
              activeColor: wrColors.wrPrimary,
              value: 1,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  radioBtnItem = 'Device';
                  id = 1;
                  print('디바이스 세팅 설정 시작');
                });
              },
            ),
            Text(
              'Device',
              style: new TextStyle(fontSize: 17.0),
            ),
            Radio(
              activeColor: wrColors.wrPrimary,
              value: 2,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  radioBtnItem = 'Chart';
                  id = 2;
                  print('차트 세팅 설정 시작');
                });
              },
            ),
            Text(
              'Chart',
              style: new TextStyle(
                fontSize: 17.0,
              ),
            ),
          ],
        ),
        Padding(
            padding: EdgeInsets.all(14.0),
            child: Text('선택된 메뉴 = ' + '$radioBtnItem',
                style: TextStyle(fontSize: 21))),
      ],
    );
  }
}
