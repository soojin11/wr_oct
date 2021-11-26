import 'package:flutter/material.dart';

class wrAppBarDivider extends StatelessWidget {
  const wrAppBarDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      color: Colors.black.withOpacity(0.5),
    );
  }
}
