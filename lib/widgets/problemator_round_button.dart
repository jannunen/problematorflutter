import 'package:flutter/material.dart';
import 'package:problemator/ui/theme/problemator_theme.dart';

class ProblematorRoundButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final String text;
  final Widget child;
  final double iconSize;
  ProblematorRoundButton({this.icon, this.onPressed, this.text, this.child, this.iconSize});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return RaisedButton(
      color: theme.colorScheme.roundButtonBackground,
      textColor: theme.colorScheme.roundButtonBackground,
      onPressed: () => this.onPressed,
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          children: [
            (this.icon != null)
                ? Icon(
                    this.icon,
                    color: theme.colorScheme.roundButtonTextColor,
                    size: this.iconSize,
                  )
                : this.child,
            Text(this.text ?? "", style: TextStyle(fontSize: 11, color: theme.primaryColor)),
          ],
        ),
      ),
      shape: CircleBorder(),
    );
  }
}
