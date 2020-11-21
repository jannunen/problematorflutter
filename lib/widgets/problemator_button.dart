import 'package:flutter/material.dart';

class ProblematorButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  ProblematorButton({this.onPressed, this.child});

  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return RaisedButton(
        color: theme.buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, right: 12, bottom: 10.0, left: 12),
          child: child,
        ));
  }
}
