import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/service/database/setting/setting_dao.dart';
import 'package:wr_ui/service/database/setting/setting_model.dart';

//장바구니 CRUD 예제...
Future<Map<String, dynamic>> recipesDialog(
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
      var top = 100.0;
      var left = 800.0;

      return StatefulBuilder(
        builder: (BuildContext ctx, StateSetter setState) {
          return GestureDetector(
            onVerticalDragUpdate: (DragUpdateDetails dd) {
              print(dd);
              setState(() {
                top = dd.localPosition.dy;
                left = dd.localPosition.dx;
              });
            },
            child: Stack(children: [
              Positioned(
                top: top,
                left: left,
                child: SimpleDialog(
                  contentPadding: EdgeInsets.zero,
                  titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
                  title: Text('Recipe'),
                  children: [
                    Column(
                      children: [
                        Divider(
                          thickness: 0.3,
                          color: Colors.grey[700],
                        ),
                        //레시피리스트
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            recipeList(),
                          ],
                        ),

//레시피리스트
                        ///////////차트세팅
                        Divider(
                          thickness: 0.3,
                          color: Colors.grey[700],
                        ),

                        ///텍스트폼 넣기
                        ///텍스트폼 넣기
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 16.0, left: 6.0, right: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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
                            child: Text('Recipe Save'),
                            style: ElevatedButton.styleFrom(
                                primary: wrColors.wrPrimary),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: wrColors.wrPrimary,
                            ),
                            onPressed: () {
                              print('레시피 삭제');
                            },
                            child: Text('Delete'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: wrColors.wrPrimary,
                            ),
                            onPressed: () {
                              print('레시피 선택');
                            },
                            child: Text('Select'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          );
        },
      );
    },
  );
}

class recipeList extends StatefulWidget {
  const recipeList({Key? key}) : super(key: key);

  @override
  _recipeListState createState() => _recipeListState();
}

class _recipeListState extends State<recipeList> {
  List<OESSet> OESset = [];
  OESsetDAO _OESsetDAO = OESsetDAO();

  void selectConfigInDialog() async {
    try {
      List<OESSet> aaa = await _OESsetDAO.selectOESsetDao();
      OESset.clear();
      OESset.addAll(aaa);
      setState(() {});
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('에러')));
    }
  }

  @override
  void initState() {
    selectConfigInDialog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            itemCount: OESset.length,
            itemBuilder: (context, index) {
              OESSet oesSet = OESset[index];
              return ListTile(
                title: Text(oesSet.ExposureTime.toString()),
                subtitle: Text(oesSet.DelayTime.toString()),
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ModifyOESSet(
                          OESset: oesSet,
                        ),
                      )).then((value) => selectConfigInDialog());
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ModifyOESSet(),
                        )).then((value) => selectConfigInDialog());
                  },
                  child: Text('Edit Recipe')),
              // ElevatedButton(onPressed: () {}, child: Text('Delete')),
              // ElevatedButton(onPressed: () {}, child: Text('Select'))
            ],
          )
        ],
      ),
    );
  }
}

class ModifyOESSet extends StatefulWidget {
  OESSet? OESset;
  ModifyOESSet({this.OESset});

  @override
  _ModifyOESSetState createState() => _ModifyOESSetState();
}

class _ModifyOESSetState extends State<ModifyOESSet> {
  final _formKey = GlobalKey<FormState>();
  OESSet OESset = OESSet.empty();
  TextEditingController _txtExposureTime = TextEditingController();
  TextEditingController _txtDelayTime = TextEditingController();
  OESsetDAO _OESsetDAO = OESsetDAO();

  void startForm() {
    if (widget.OESset != null) {
      _txtExposureTime.text = widget.OESset!.ExposureTime.toString();
      _txtDelayTime.text = widget.OESset!.DelayTime.toString();
      OESset = widget.OESset!;
    }
  }

  void save() {
    OESset.ExposureTime = _txtExposureTime.text;
    OESset.DelayTime = _txtDelayTime.text;
    if (OESset.id == null) {
      addConfig();
      return;
    }
  }

  void addConfig() async {
    try {
      OESSet aaa = await _OESsetDAO.addNewOESsetDao(OESset);
      OESset.id = aaa.id;
      msg('컨피그 추가 성공');
      setState(() {});
    } catch (error) {
      print(error);
      msg('컨피그 추가 에러');
    }
  }

  void modifyOESSet() async {
    try {
      if (await _OESsetDAO.modifyOESsetDao(OESset)) {
        msg('업데이트 성공');
        return;
      }
      msg('asadd');
    } catch (error) {
      print(error);
      msg('컨피그 업데이트 에러');
    }
  }

  void delete() async {
    try {
      if (OESset.id != null) {
        if (await _OESsetDAO.deleteOESsetDao(OESset)) {
          msg('컨피그 삭제 성공');
          Navigator.pop(context);
          return;
        }
        msg('dd');
      }
      msg('ddd');
    } catch (error) {
      print(error);
      msg('컨피그 삭제 에러');
    }
  }

  void msg(String menssagem) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(menssagem)));
  }

  @override
  void initState() {
    startForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _txtExposureTime,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'ExposureTime을 정해주세요';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'ExposureTime',
                  ),
                ),
                TextFormField(
                  controller: _txtDelayTime,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'DelayTime를 정해주세요';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'DelayTime',
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            save();
                          }
                        },
                        child: Text('Save'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          OESset.id == null ? print('삭제 불가능') : delete();
                        },
                        child: Text('삭제'),
                        style: ElevatedButton.styleFrom(
                          primary: OESset.id == null ? Colors.grey : Colors.red,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}


// ModifyOESSet({Config config}) {
// }

