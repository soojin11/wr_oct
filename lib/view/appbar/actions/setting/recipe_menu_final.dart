import 'package:flutter/material.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/view/appbar/actions/setting/recipe_dialog_final.dart';

class RecipeMenu extends StatefulWidget {
  @override
  State<RecipeMenu> createState() => _RecipeMenuState();
}

class _RecipeMenuState extends State<RecipeMenu> {
  Map<String, dynamic> recipePage = <String, dynamic>{
    //디바이스세팅
    'deviceName': 'firstDevice',
    'interval': 200.22,
    'unit': 'aa',

    ///차트세팅
    'chartName': 'firstChart',
    'chartColor': 'green',
    'chartTheme': 'bar type',
    'seriesType': 'aaa',
    'scaleValue': 20.33
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: wrColors.wrPrimary),
        onPressed: () {
          recipesDialog(context, recipePage)
              .then((Map<String, dynamic> recipes) {
            setState(() {
              recipePage = recipes;
            });
            print(recipePage);
          });
        },
        child: Container(
          width: 200,
          child: Center(
            child: Text('Recipe'),
          ),
        ),
      ),
    );
  }
}
