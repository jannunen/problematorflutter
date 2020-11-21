import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:problemator/core/problemator_theme.dart';

class OpenAddProblemDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
        alignment: Alignment.bottomCenter,
        child: Column(children: [
          Text("Find route"),
          Row(
            children: [
              RaisedButton(
                color: theme.colorScheme.roundButtonBackground,
                textColor: theme.colorScheme.roundButtonBackground,
                onPressed: null,
                child: Icon(
                  Icons.camera,
                  color: theme.colorScheme.roundButtonBackground,
                  size: 26,
                ),
              ),
              TextField(decoration: InputDecoration(hintText: "Route name (or code)")),
            ],
          ),
        ]));
  }
}
