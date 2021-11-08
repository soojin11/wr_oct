import 'package:flutter/material.dart';
import 'package:wr_ui/style/pallette.dart';

Future<Map<String, dynamic>> settingsDialog(
    BuildContext context, Map<String, dynamic> settings) async {
  return await showDialog(
    barrierColor: null,
    barrierDismissible: false,
    context: context,
    builder: (BuildContext ctx) {
      ////디바이스
      String deviceName = settings['deviceName'].toString();
      double interval = settings['interval'] as double;
      String unit = settings['unit'].toString();
      ////차트
      String chartName = settings['chartName'].toString();
      String chartColor = settings['chartColor'].toString();
      String chartTheme = settings['chartTheme'].toString();
      String seriesType = settings['seriesType'].toString();
      double scaleValue = settings['scaleValue'] as double;

      return StatefulBuilder(
        builder: (BuildContext ctx, StateSetter setState) {
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            title: Text('Settings'),
            children: [
              Column(
                children: [
                  Divider(
                    thickness: 0.3,
                    color: Colors.grey[700],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Text(
                          'Device Setting',
                          style: TextStyle(
                            fontSize: 20,
                            color: wrColors.wrPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      initialValue: deviceName,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.label),
                        labelText: 'DeviceName',
                      ),
                      onChanged: (String value) {
                        setState(() {
                          deviceName = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      initialValue: interval.toString(),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.label),
                        labelText: 'interval',
                      ),
                      onChanged: (var value) {
                        setState(() {
                          interval = double.parse(value);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      initialValue: unit.toString(),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.label),
                        labelText: 'unit',
                      ),
                      onChanged: (String value) {
                        setState(() {
                          unit = value;
                        });
                      },
                    ),
                  ),
                  ///////////차트세팅
                  Divider(
                    thickness: 0.3,
                    color: Colors.grey[700],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Text(
                          'Chart Setting',
                          style: TextStyle(
                            fontSize: 20,
                            color: wrColors.wrPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      initialValue: chartName,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.label),
                        labelText: 'Chart Name',
                      ),
                      onChanged: (String value) {
                        setState(() {
                          chartName = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      initialValue: chartColor.toString(),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.label),
                        labelText: 'Chart Color',
                      ),
                      onChanged: (String value) {
                        setState(() {
                          chartColor = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      initialValue: chartTheme.toString(),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.label),
                        labelText: 'Chart Theme',
                      ),
                      onChanged: (String value) {
                        setState(() {
                          chartTheme = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      initialValue: seriesType.toString(),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.label),
                        labelText: 'Series Type',
                      ),
                      onChanged: (String value) {
                        setState(() {
                          seriesType = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      initialValue: scaleValue.toString(),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.label),
                        labelText: 'Scale Value',
                      ),
                      onChanged: (String value) {
                        setState(() {
                          scaleValue = double.parse(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .pop(<String, dynamic>{
                    'deviceName': deviceName,
                    'interval': interval,
                    'unit': unit,

                    ///차트세팅
                    'chartName': chartName,
                    'chartColor': chartColor,
                    'chartTheme': chartTheme,
                    'seriesType': seriesType,
                    'scaleValue': scaleValue
                  });
                },
                child: Text('Apply'),
                style: ElevatedButton.styleFrom(primary: wrColors.wrPrimary),
              ),
            ],
          );
        },
      );
    },
  );
}
