import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:problemator/core/screen_helpers.dart';
import 'package:problemator/models/problem_extra_info.dart';
import 'package:problemator/widgets/problemator_action_button.dart';
import 'package:problemator/widgets/problemator_round_button.dart';
import 'package:problemator/ui/theme/problemator_theme.dart';

class BottomSheetAddTick extends StatefulWidget {
  final ProblemExtraInfo problemExtraInfo;
  BottomSheetAddTick({this.problemExtraInfo});
  @override
  State<StatefulWidget> createState() =>
      _BottomSheetAddTick(problemExtraInfo: this.problemExtraInfo);
}

class _BottomSheetAddTick extends State<BottomSheetAddTick> {
  final ProblemExtraInfo problemExtraInfo;
  String _ascentType = 'send';

  _BottomSheetAddTick({this.problemExtraInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 24,
        ),
        _buildTryInfoHeader(context),
        _buildAddTickAction(context),
      ],
    ));
  }

  Widget _buildTryInfoHeader(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Container(
        decoration: BoxDecoration(
            color: colorScheme.leftPaneBackground,
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        height: displayHeight(context) * 0.3,
        child: Padding(
          padding: const EdgeInsets.only(top: 18, right: 8, bottom: 2, left: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCalendarButton(context),
                  _buildTriesButton(context),
                  _buildGradeOpinionButton(context),
                ],
              ),
              _buildRadioBoxes(context),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: _buildButton(context),
              ),
            ],
          ),
        ));
  }

  Widget _buildAddTickAction(BuildContext context) {
    return Container();
  }

  Widget _buildTriesButton(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Column(
      children: [
        ClipOval(
            child: Material(
                color: theme.colorScheme.roundButtonBackground,
                child: InkWell(
                    child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text("1", style: TextStyle(fontSize: 24, color: theme.primaryColor)),
                  )),
                )))),
        Text("Tries"),
      ],
    );
  }

  Widget _buildCalendarButton(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Column(
      children: [
        ClipOval(
            child: Material(
                color: theme.colorScheme.roundButtonBackground,
                child: InkWell(
                    child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Icon(Icons.calculate_outlined),
                  )),
                )))),
        Text("Today"),
      ],
    );
  }

  Widget _buildGradeOpinionButton(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Column(
      children: [
        ClipOval(
            child: Material(
                color: theme.colorScheme.roundButtonBackground,
                child: InkWell(
                    child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text("6B+", style: textTheme.headline1),
                  )),
                )))),
        Text("Grade opinion"),
      ],
    );
  }

  Widget _buildRadioBoxes(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: RadioListTile(
            title: Text("Send"),
            groupValue: _ascentType,
            value: 'send',
            onChanged: (val) {
              setState(() {
                _ascentType = val;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile(
            title: Text("Still projecting"),
            groupValue: _ascentType,
            value: 'projecting',
            onChanged: (val) {
              setState(() {
                _ascentType = val;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return ProblematorActionButton(
        onPressed: () {},
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, size: 20),
              Text("Add a tick", style: textTheme.headline6.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ));
  }
}
