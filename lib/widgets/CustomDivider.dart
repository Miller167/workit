import 'package:flutter/material.dart';

import '../resources/constants.dart';

class CustomDivider extends StatelessWidget {
  double padding;

  CustomDivider({required this.padding, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Center(
      child: Container(
        padding: EdgeInsets.all(padding),
        height: 1.25,
        width: media.width / 1.1,
        decoration: BoxDecoration(
          color: kGrey4,
        ),
      ),
    );
  }
}
