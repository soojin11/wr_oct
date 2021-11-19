import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/model/pallette.dart';
import 'package:wr_ui/service/database/recipe/config_dao.dart';
import 'package:wr_ui/service/database/recipe/config_model.dart';

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
  List<Config> configs = [];
  ConfigDAO _configDAO = ConfigDAO();

  void selectConfigInDialog() async {
    try {
      List<Config> aaa = await _configDAO.selectConfigDao();
      configs.clear();
      configs.addAll(aaa);
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
            itemCount: configs.length,
            itemBuilder: (context, index) {
              Config config = configs[index];
              return ListTile(
                title: Text(config.name),
                subtitle: Text(config.config),
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ModifyConfig(
                          config: config,
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
                          builder: (context) => ModifyConfig(),
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

class ModifyConfig extends StatefulWidget {
  Config? config;
  ModifyConfig({this.config});

  @override
  _ModifyConfigState createState() => _ModifyConfigState();
}

class _ModifyConfigState extends State<ModifyConfig> {
  final _formKey = GlobalKey<FormState>();
  Config config = Config.empty();
  TextEditingController _txtName = TextEditingController();
  TextEditingController _txtConfig = TextEditingController();
  ConfigDAO _configDAO = ConfigDAO();

  void startForm() {
    if (widget.config != null) {
      _txtName.text = widget.config!.name;
      _txtConfig.text = widget.config!.config;
      config = widget.config!;
    }
  }

  void save() {
    config.name = _txtName.text;
    config.config = _txtConfig.text;
    if (config.id == null) {
      addConfig();
      return;
    }
  }

  void addConfig() async {
    try {
      Config aaa = await _configDAO.addNewConfigDao(config);
      config.id = aaa.id;
      msg('컨피그 추가 성공');
      setState(() {});
    } catch (error) {
      print(error);
      msg('컨피그 추가 에러');
    }
  }

  void modifyConfig() async {
    try {
      if (await _configDAO.modifyConfigDao(config)) {
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
      if (config.id != null) {
        if (await _configDAO.deleteConfigDao(config)) {
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
                  controller: _txtName,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'name을 정해주세요';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextFormField(
                  controller: _txtConfig,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return '컨피그를 정해주세요';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Config',
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
                          config.id == null ? print('삭제 불가능') : delete();
                        },
                        child: Text('삭제'),
                        style: ElevatedButton.styleFrom(
                          primary: config.id == null ? Colors.grey : Colors.red,
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


// ModifyConfig({Config config}) {
// }
