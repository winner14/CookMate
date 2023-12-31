import 'package:flutter/material.dart';
import 'package:mini_project/constants.dart';

class GenieLine extends StatelessWidget {
  final double? width;
  const GenieLine({Key? key, this.width = double.infinity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).brightness == Brightness.dark
              ? myPrimaryColorDark
              : myPrimaryColorLight
          : myPrimaryDarkColor,
    );
  }
}
