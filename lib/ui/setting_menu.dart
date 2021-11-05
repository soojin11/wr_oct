import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/style/pallette.dart';
import 'package:wr_ui/style/text.dart';

class SettingMenu extends StatelessWidget {
  const SettingMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton.icon(
        onPressed: () {
          print('세팅다이얼로그창띄울곳');
          //겟엑스 다이얼로그
          // Get.defaultDialog(

          // barrierDismissible: false,
          // title: '겟엑스다이얼로그 테스트',
          // middleText: '미들텍스트영역',
          // content: Column(
          // children: [
          // Container(
          // child: Text('설정 1'),
          // ),
          // Container(
          // child: Text('설정 2'),
          // ),
          // Container(
          // child: Text('설정 3'),
          // ),
          // Container(
          // child: Text('설정 4'),
          // ),
          // Container(
          // child: Text('설정 5'),
          // ),
          // Container(
          // child: Text('설정 6'),
          // ),
          // Container(
          // child: Text('설정 7'),
          // ),
          // Container(
          // child: Text('설정 8'),
          // ),
          // Container(
          // child: Text('설정 9'),
          // ),
          // Container(
          // child: Text('설정 10'),
          // ),
          // ],
          // ),
          //////세팅적용버튼
          // onConfirm: () {
          // Navigator.of(context).pop();
          // },
          // textConfirm: 'Apply',
          // confirmTextColor: Colors.white,
          // buttonColor: wrColors.wrPrimary,
          //
          //////세팅적용버튼

          //////세팅취소버튼
          // onCancel: () {
          // Navigator.of(context).pop();
          // },
          // textCancel: 'Cancel',
          // cancelTextColor: wrColors.wrPrimary
////////세팅취소버튼
          //겟엑스 다이얼로그
          showDialog(
              //배경 안어둡게

              barrierDismissible: false,
              barrierColor: null,
              //배경 안어둡게
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                print('세팅창 닫음');

                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.close,
                                color: wrColors.wrPrimary,
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('세팅다이얼로그 테스트'),
                        ],
                      ),
                    ],
                  ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        Text('다이얼로그 컨텐츠 테스트1'),
                        Text('다이얼로그 컨텐츠 테스트2'),
                        Text('다이얼로그 컨텐츠 테스트3'),
                        Text('다이얼로그 컨텐츠 테스트4'),
                        Text('다이얼로그 컨텐츠 테스트1'),
                        Text('다이얼로그 컨텐츠 테스트2'),
                        Text('다이얼로그 컨텐츠 테스트3'),
                        Text('다이얼로그 컨텐츠 테스트4'),
                        Text('다이얼로그 컨텐츠 테스트1'),
                        Text('다이얼로그 컨텐츠 테스트2'),
                        Text('다이얼로그 컨텐츠 테스트3'),
                        Text('다이얼로그 컨텐츠 테스트4'),
                        Text('다이얼로그 컨텐츠 테스트1'),
                        Text('다이얼로그 컨텐츠 테스트2'),
                        Text('다이얼로그 컨텐츠 테스트3'),
                        Text('다이얼로그 컨텐츠 테스트4'),
                        Text('다이얼로그 컨텐츠 테스트1'),
                        Text('다이얼로그 컨텐츠 테스트2'),
                        Text('다이얼로그 컨텐츠 테스트3'),
                        Text('다이얼로그 컨텐츠 테스트4'),
                        Text('다이얼로그 컨텐츠 테스트1'),
                        Text('다이얼로그 컨텐츠 테스트2'),
                        Text('다이얼로그 컨텐츠 테스트3'),
                        Text('다이얼로그 컨텐츠 테스트4'),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: wrColors.wrPrimary),
                      onPressed: () {
                        print('세팅적용');
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Apply',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    OutlinedButton(
                      style:
                          OutlinedButton.styleFrom(primary: wrColors.wrPrimary),
                      onPressed: () {
                        print('세팅창 닫음');
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    )
                  ],
                );
              });
        },
        icon: Icon(
          Icons.settings,
          color: Colors.white,
        ),
        label: Text(
          'Setting',
          style: WrText.WrLeadingFont,
        ),
      ),
    );
  }
}
