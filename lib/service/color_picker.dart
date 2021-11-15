import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorContainer extends StatefulWidget {
  @override
  State<ColorContainer> createState() => _ColorContainerState();
}

class _ColorContainerState extends State<ColorContainer> {
  Color color = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              width: 20,
              height: 20,
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {
                pickColor(context);
              },
              child: Text(
                '컬러 픽!',
                style: TextStyle(fontSize: 24),
              ),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildColorPicker() => ColorPicker(
        pickerColor: color,
        enableAlpha: false,
        showLabel: false,
        onColorChanged: (color) => setState(() => this.color = color),
      );

  void pickColor(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('컬러를 선택하세요'),
            content: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildColorPicker(),
                  Text(
                    '선택하세요',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
