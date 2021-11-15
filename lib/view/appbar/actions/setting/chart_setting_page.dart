/*
--------------차트 세팅---------------------
1. 차트색깔
2. 테마
3. 시리즈타입
4. 스케일값
5.두께

-----------디바이스 세팅 파라미터-------------
1. integration
2. interval
3. unit
4. 
*/
//지원자 데이터 생성
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import 'package:syncfusion_flutter_core/theme.dart';
// import 'package:wr_ui/main.dart';
// import 'package:wr_ui/service/color_picker.dart';
// import 'package:wr_ui/ui/appbar/clock.dart';

// class SettingList {
//   SettingList(this.chartNum, this.chartColor, this.theme, this.seriesType,
//       this.scaleValue);
//   final int chartNum;
//   final Widget chartColor;
//   final String theme;
//   final String seriesType;
//   final double scaleValue;
// }
// //지원자 데이터 생성

// //데이터소스 만들기
// class SettingDataSource extends DataGridSource {
//   SettingDataSource({List<SettingList>? setting}) {
//     _setting = setting!
//         .map<DataGridRow>((e) => DataGridRow(cells: [
//               DataGridCell<int>(columnName: 'chartNum', value: e.chartNum),
//               DataGridCell<Widget>(
//                   columnName: 'chartColor', value: e.chartColor),
//               DataGridCell<String>(columnName: 'theme', value: e.theme),
//               DataGridCell<String>(
//                   columnName: 'seriesType', value: e.seriesType),
//               DataGridCell<double>(
//                   columnName: 'scaleValue', value: e.scaleValue),
//             ]))
//         .toList();
//   }

//   List<DataGridRow> _setting = [];

//   @override
//   List<DataGridRow> get rows => _setting;

//   @override
//   DataGridRowAdapter? buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         cells: row.getCells().map<Widget>((dataGridCell) {
//       return Container(
//         alignment: (dataGridCell.columnName == 'num' ||
//                 dataGridCell.columnName == 'etc')
//             ? Alignment.centerRight
//             : Alignment.centerLeft,
//         padding: EdgeInsets.all(16.0),
//         child: Text(dataGridCell.value.toString()),
//       );
//     }).toList());
//   }
// }
// //데이터소스 만들기

// class ChartSettings extends StatefulWidget {
//   @override
//   _ChartSettingsState createState() => _ChartSettingsState();
// }

// class _ChartSettingsState extends State<ChartSettings> {
//   //이니셜라이즈
//   List<SettingList> setting = <SettingList>[];

//   late SettingDataSource settingDataSource;

//   @override
//   void initState() {
//     super.initState();
//     setting = getSettings();
//     settingDataSource = SettingDataSource(setting: setting);
//   }

//   var colorselect = ColorContainer();
//   List<SettingList> getSettings() {
//     return [
//       SettingList(1, colorselect, 'theme1', 'a', 5),
//       SettingList(2, colorselect, 'theme2', 'd', 3),
//       SettingList(3, colorselect, 'theme3', 'b', 8),
//       SettingList(4, colorselect, 'theme4', 'e', 6),
//     ];
//   }

//   late Map<String, double> columnWidths = {
//     'chartNum': double.nan,
//     'chartColor': double.nan,
//     'theme': double.nan,
//     'seriesType': double.nan,
//     'scaleValue': double.nan
//   };
// //이니셜라이즈
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: WRappbar(),
//       body: Column(
//         // mainAxisAlignment: Main,
//         children: [
//           SizedBox(
//             height: 50,
//           ),
//           Text(
//             'Chart Setting Page',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 50),
//             child: Container(
//               child: SfDataGridTheme(
//                 data: SfDataGridThemeData(
//                     headerColor: Colors.blueGrey[100],
//                     rowHoverColor: Colors.blueAccent[100],
//                     rowHoverTextStyle: TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.bold)),
//                 child: SfDataGrid(
//                   selectionMode: SelectionMode.multiple,
//                   allowSorting: true,
//                   allowEditing: true,
//                   editingGestureType: EditingGestureType.tap,
//                   source: settingDataSource,
//                   // footer: Container(
//                   // color: Colors.grey[400],
//                   // child: Center(
//                   // child: Text(
//                   // '더 보기',
//                   // style: TextStyle(fontWeight: FontWeight.bold),
//                   // ))),
//                   allowColumnsResizing: true,
//                   onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
//                     setState(() {
//                       columnWidths[details.column.columnName] = details.width;
//                     });
//                     return true;
//                   },
//                   columnWidthMode: ColumnWidthMode.fill,
//                   columns: <GridColumn>[
//                     GridColumn(
//                         //  final int chartNum;
//                         // final String chartColor;
//                         // final String theme;
//                         // final String seriesType;
//                         // final double scaleValue;
//                         width: columnWidths['chartNum']!,
//                         allowSorting: true,
//                         columnName: 'chartNum',
//                         label: Container(
//                             padding: EdgeInsets.all(16.0),
//                             alignment: Alignment.centerRight,
//                             child: Text(
//                               'chartNum',
//                             ))),
//                     GridColumn(
//                         width: columnWidths['chartColor']!,
//                         columnName: 'chartColor',
//                         label: Container(
//                             padding: EdgeInsets.all(16.0),
//                             alignment: Alignment.centerLeft,
//                             child: Text('chartColor'))),
//                     GridColumn(
//                         width: columnWidths['theme']!,
//                         columnName: 'theme',
//                         label: Container(
//                             padding: EdgeInsets.all(16.0),
//                             alignment: Alignment.centerLeft,
//                             child: Text('theme'))),
//                     GridColumn(
//                         width: columnWidths['seriesType']!,
//                         columnName: 'seriesType',
//                         label: Container(
//                             padding: EdgeInsets.all(16.0),
//                             alignment: Alignment.centerRight,
//                             child: Text('seriesType'))),
//                     GridColumn(
//                         width: columnWidths['scaleValue']!,
//                         columnName: 'scaleValue',
//                         label: Container(
//                             padding: EdgeInsets.all(16.0),
//                             alignment: Alignment.centerRight,
//                             child: Text('scaleValue')))
//                   ],
//                   gridLinesVisibility: GridLinesVisibility.both,
//                   headerGridLinesVisibility: GridLinesVisibility.both,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/service/color_picker.dart';

class ChartSettings extends StatefulWidget {
  const ChartSettings({Key? key}) : super(key: key);

  @override
  _ChartSettingsState createState() => _ChartSettingsState();
}

class _ChartSettingsState extends State<ChartSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WRappbar(),
        body: Container(
          child: Column(
            children: [
              Container(
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), //그림자 색
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 2), // 그림자위치 바꾸는거
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Column(
                      children: [ColorContainer()],
                    ),
                    Column(
                      children: [],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
