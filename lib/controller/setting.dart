import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

// ignore: must_be_immutable
class ColorSet extends StatelessWidget {
  ColorSet({Key? key, required this.text, required this.onColorChanage})
      : super(key: key);
  String text;
  ValueChanged<Color> onColorChanage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 15),
          ),
        ),
        Container(
          height: 60,
          width: 260,
          child: Center(
            child: MaterialColorPicker(
              iconSelected: IconData(0),
              circleSize: 190,
              onColorChange: onColorChanage,
              colors: [
                Colors.red,
                Colors.deepOrange,
                Colors.yellow,
                Colors.lightGreen
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class ComSet extends StatelessWidget {
  ComSet(
      {Key? key,
      required this.onSaved,
      required this.initVal,
      required this.label})
      : super(key: key);
  FormFieldSetter<String>? onSaved;
  String initVal;
  String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 80,
      child: TextFormField(
          initialValue: initVal,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: label,
            hintText: 'COM',
          ),
          onSaved: onSaved),
    );
  }
}
