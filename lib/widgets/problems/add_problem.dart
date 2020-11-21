import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:problemator/core/problemator_theme.dart';
import 'package:problemator/core/screen_helpers.dart';
import 'package:problemator/core/problemator_theme.dart';
import 'package:problemator/widgets/problemator_button.dart';

class AddProblemForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Container(
        height: displayHeight(context) * 0.5,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            color: Theme.of(context).bottomSheetTheme.backgroundColor,
            borderRadius: BorderRadius.circular(16)),
        child: Column(children: [
          SizedBox(
            height: 8,
          ),
          Text("Find route", style: textTheme.headline5),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    RaisedButton(
                      color: theme.colorScheme.roundButtonBackground,
                      textColor: theme.colorScheme.roundButtonBackground,
                      onPressed: () => _openQRCodeScanner(),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: theme.colorScheme.roundButtonTextColor,
                              size: 26,
                            ),
                            Text("Scan QR",
                                style: TextStyle(fontSize: 11, color: theme.primaryColor)),
                          ],
                        ),
                      ),
                      shape: CircleBorder(),
                    ),
                    Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: colorScheme.textFieldBorderRadius,
                              ),
                              prefixIcon: Icon(Icons.search),
                              hintText: "Route name (or code)")),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: 30,
                      left: displayWidth(context) * 0.1,
                      right: displayWidth(context) * 0.1),
                  child: Center(
                    child: ProblematorButton(
                        onPressed: () => _openFloorPlanSelector(), child: Text("Open floorplan")),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }

  void _openQRCodeScanner() {
    // noip for now
  }

  _openFloorPlanSelector() {}
}
