import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wr_ui/ui/appbar/drop_down/drop_down_chart.dart';
//디바이스개수,주기만 일단

class ChartPage extends StatefulWidget {
  const ChartPage();

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  late Timer _timer;

  final List<_ChartData> _chartData = <_ChartData>[
    _ChartData(DateTime.now(), 5),
  ];

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), _getChartData);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //all oes vi +선택하는 드롭다운

        //all oes vi +선택하는 드롭다운
        SfCartesianChart(
          enableAxisAnimation: true,
          primaryXAxis:
              DateTimeAxis(intervalType: DateTimeIntervalType.seconds),
          series: <LineSeries<_ChartData, DateTime>>[
            LineSeries(
              color: Colors.blue,
              dataSource: _chartData,
              xValueMapper: (_ChartData sales, _) => sales.x,
              yValueMapper: (_ChartData sales, _) => sales.y,
            )
          ],
        ),
      ],
    );
  }

  void _getChartData(Timer timer) {
    _ChartData date = _chartData[_chartData.length - 1];
    _chartData.add(_ChartData(
        DateTime(date.x.year, date.x.month, date.x.day, date.x.hour,
            date.x.minute, date.x.second + 1),
        _getRandomInt(10, 30)));
    setState(() {});
  }

  int _getRandomInt(int min, int max) {
    final Random random = Random();
    return min + random.nextInt(max - min);
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final DateTime x;
  final int y;
}
