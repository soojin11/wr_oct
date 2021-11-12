import 'package:flutter/material.dart';
import 'package:wr_ui/const/style/text.dart';

// class runErrorStatusMark extends StatelessWidget {
// const runErrorStatusMark({Key? key}) : super(key: key);
// final device = 1;

// @override
// Widget build(BuildContext context) {
// return ElevatedButton(
// onPressed: () {
// if (device == 1) {
// print('모두 정상연결');
// } else {
// print('object');
// }
// },
// child: Text('aaa'),

// 1. import 'package:flutter/material.dart';

// 디바이스 전부 체크해서 모두 정상연결 -> run,green
// 2. 디바이스 전부  시뮬레이션이면 -> SIM,yellow
// 3. 데이터들을 차트에 기록중에 에러발생->stop,데이터 기록 중지
// );
// }
// }
class RunErrorStatus extends StatelessWidget {
  const RunErrorStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Text(
        'Run/Error status',
        style: WrText.WrLeadingFont,
      ),
    );
  }
}
