import 'package:flutter/material.dart';

class ProblematorActionButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  ProblematorActionButton({@required this.child, @required this.onPressed})
      : assert(onPressed != null);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: this.onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: this.child,
      color: Color.fromRGBO(254, 95, 85, 1.0),
    );
  }
}
