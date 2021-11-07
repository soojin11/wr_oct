import 'package:flutter/material.dart';

class MyList extends StatelessWidget {
  MyList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final europeanCountries = [
      'Program Start',
      'Pressed Start',
      'Start Saving File',
      'Stop Saving File',
      '로그 기능',
      '넣어야 함',
    ];
    return Column(
      children: [
        Flexible(
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: europeanCountries.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(europeanCountries[index]),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ),
        ),
      ],
    );
  }
}