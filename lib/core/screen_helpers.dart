import 'package:flutter/material.dart';
/*
Thanks: https://medium.com/tagmalogic/widgets-sizes-relative-to-screen-size-in-flutter-using-mediaquery-3f283afc64d6
*/

Size displaySize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  debugPrint('Height = ' + displaySize(context).height.toString());
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  debugPrint('Width = ' + displaySize(context).width.toString());
  return displaySize(context).width;
}
