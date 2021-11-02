/*
--------------차트 세팅---------------------
1. 차트색깔
2. 테마
3. 시리즈타입
4. 스케일값
-----------디바이스 세팅 파라미터-------------
1. integration
2. interval
3. unit
4. 
*/
//지원자 데이터 생성
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/ui/widgets/clock.dart';

class SettingList {
  SettingList(this.num, this.parameters, this.value, this.etc);
  final int num;
  final String parameters;
  final double value;
  final int etc;
}
//지원자 데이터 생성

//데이터소스 만들기
class SettingDataSource extends DataGridSource {
  SettingDataSource({List<SettingList>? setting}) {
    _setting = setting!
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'num', value: e.num),
              DataGridCell<String>(
                  columnName: 'parameters', value: e.parameters),
              DataGridCell<double>(columnName: 'value', value: e.value),
              DataGridCell<int>(columnName: 'etc', value: e.etc),
            ]))
        .toList();
  }

  List<DataGridRow> _setting = [];

  @override
  List<DataGridRow> get rows => _setting;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: (dataGridCell.columnName == 'num' ||
                dataGridCell.columnName == 'etc')
            ? Alignment.centerRight
            : Alignment.centerLeft,
        padding: EdgeInsets.all(16.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
//데이터소스 만들기

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  //이니셜라이즈
  List<SettingList> setting = <SettingList>[];

  late SettingDataSource settingDataSource;

  @override
  void initState() {
    super.initState();
    setting = getSettings();
    settingDataSource = SettingDataSource(setting: setting);
  }

  List<SettingList> getSettings() {
    return [
      SettingList(10001, 'Integration', 11, 20000),
      SettingList(10002, 'Interval', 11, 30000),
      SettingList(10003, 'Unit', 11, 15000),
    ];
  }

  late Map<String, double> columnWidths = {
    'num': double.nan,
    'parameters': double.nan,
    'value': double.nan,
    'etc': double.nan
  };
//이니셜라이즈
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          // backgroundColor: Theme.of(context).backgroundColor,
          leading: TextButton(
            onPressed: () {
              Get.to(Home());
            },
            child: Image.asset(
              'assets/images/CI_nobg.png',
              scale: 10,
            ),
          ),
          actions: [
            Spacer(),
            Clock(),
            Spacer(),
            Text(
              'ExampleRecipeName',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text('4. Run/Error status'),
            Spacer(),
            Row(
              children: [
                TextButton.icon(
                    onPressed: () {
                      print('setting버튼클릭');
                    },
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Settings',
                      style: TextStyle(color: Colors.white),
                    ))
                // Icon(Icons.settings),
                // Text('5.Settings'),
              ],
            ),
          ] //
          ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            'OES',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              child: SfDataGridTheme(
                data: SfDataGridThemeData(
                    headerColor: Colors.blueGrey[100],
                    rowHoverColor: Colors.blueAccent[100],
                    rowHoverTextStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                child: SfDataGrid(
                  selectionMode: SelectionMode.multiple,
                  allowSorting: true,
                  allowEditing: true,
                  editingGestureType: EditingGestureType.tap,
                  source: settingDataSource,
                  // footer: Container(
                  // color: Colors.grey[400],
                  // child: Center(
                  // child: Text(
                  // '더 보기',
                  // style: TextStyle(fontWeight: FontWeight.bold),
                  // ))),
                  allowColumnsResizing: true,
                  onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                    setState(() {
                      columnWidths[details.column.columnName] = details.width;
                    });
                    return true;
                  },
                  columnWidthMode: ColumnWidthMode.fill,
                  columns: <GridColumn>[
                    GridColumn(
                        width: columnWidths['num']!,
                        allowSorting: true,
                        columnName: 'num',
                        label: Container(
                            padding: EdgeInsets.all(16.0),
                            alignment: Alignment.centerRight,
                            child: Text(
                              'NUM',
                            ))),
                    GridColumn(
                        width: columnWidths['parameters']!,
                        columnName: 'parameters',
                        label: Container(
                            padding: EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: Text('Parameters'))),
                    GridColumn(
                        width: columnWidths['value']!,
                        columnName: 'value',
                        label: Container(
                            padding: EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: Text('Value'))),
                    GridColumn(
                        width: columnWidths['etc']!,
                        columnName: 'etc',
                        label: Container(
                            padding: EdgeInsets.all(16.0),
                            alignment: Alignment.centerRight,
                            child: Text('Etc'))),
                  ],
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
