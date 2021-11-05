import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wr_ui/style/pallette.dart';

class filePickerBtn extends StatelessWidget {
  const filePickerBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () async {
          final result =
              await FilePicker.platform.pickFiles(allowMultiple: true);
          if (result == null) return;
          final file = result.files.first;
          openFile(file);
          //한개파일만 여는거

          // openFile(file);
          // print('파일명 : ${file.name}');
          // print('Bytes : ${file.bytes}');
          // print('사이즈 : ${file.size}');
          // print('확장자 : ${file.extension}');
          // print('파일경로 :${file.path}');

          // final newFile = await saveFilePermanently(file);

          // print('이 경로에서 : ${file.path!}');
          // print('이 경로로 : ${newFile.path}');
        },
        child: Text('Open File'),
        style: ElevatedButton.styleFrom(primary: wrColors.wrPrimary),
      );

  // void openFiles(List<PlatformFile> files) =>
  // Navigator.of(context).push(MaterialPageRoute(
  // builder: (context) => FilePage(files: files, onOpenedFile: openFile),
  // ));

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');

    return File(file.path!).copy(newFile.path);
  }
}

// void openFile(PlatformFile file) {
  // OpenFile.open(file.path);
  // print('파일명 : ${file.name}');
  // print('Bytes : ${file.bytes}');
  // print('사이즈 : ${file.size}');
  // print('확장자 : ${file.extension}');
  // print('파일경로 :${file.path}');}

///내부저장은 아직안함
