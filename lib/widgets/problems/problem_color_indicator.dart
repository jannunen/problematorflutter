import 'package:flutter/material.dart';
import 'package:problemator/core/hex_color.dart';

class ProblemColorIndicator extends StatelessWidget {
  final String htmlcolour;
  final double height;
  final double width;

  ProblemColorIndicator({this.htmlcolour, this.width = 15, this.height = 15});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: HexColor(this.htmlcolour),
      ),
    );
  }
}
