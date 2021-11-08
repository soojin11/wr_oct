import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VizChart extends StatefulWidget {
  const VizChart({Key? key}) : super(key: key);

  @override
  _VizCartState createState() => _VizCartState();
}

class _VizCartState extends State<VizChart> {
  _VizCartState();

  Timer? timer;
  late List<ChartData> chartData;

  @override
  Widget build(BuildContext context) {
    _getChartData();
    timer = Timer(const Duration(milliseconds: 100), () {
      setState(() {
        _getChartData(); // 이부분을 get으로 할라면
      });
    });

    return Row(
      children: [
        TextButton(onPressed: () {}, child: Text('Start')),
        TextButton(
            onPressed: () {
              timer?.cancel();
            },
            child: Text('Stop')),
        Expanded(
          flex: 1,
          child: SfCartesianChart(
              title: ChartTitle(text: 'VIZ'),
              plotAreaBorderWidth: 0,
              primaryXAxis:
                  NumericAxis(majorGridLines: const MajorGridLines(width: 0)),
              primaryYAxis: NumericAxis(
                  majorTickLines:
                      const MajorTickLines(color: Colors.transparent),
                  axisLine: const AxisLine(width: 0),
                  minimum: 0,
                  maximum: 50),
              series: <LineSeries<ChartData, num>>[
                LineSeries(
                    dataSource: chartData,
                    xValueMapper: (ChartData sales, _) => sales.x,
                    yValueMapper: (ChartData sales, _) => sales.y)
              ]),
        ),
      ],
    );
  }

  void _getChartData() {
    chartData = <ChartData>[];
    for (int i = 0; i < 150; i++) {
      chartData.add(ChartData(i, math.Random().nextInt(50)));
    }
    timer?.cancel();
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final int y;
}
