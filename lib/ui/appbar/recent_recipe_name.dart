import 'package:flutter/material.dart';

class RecentRecipeName extends StatelessWidget {
  const RecentRecipeName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'ExampleRecipeName',
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
