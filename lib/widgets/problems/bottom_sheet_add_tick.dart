import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:problemator/blocs/home/bloc/home_bloc.dart';
import 'package:problemator/blocs/problem/bloc/problem_bloc.dart';
import 'package:problemator/core/screen_helpers.dart';
import 'package:problemator/models/models.dart';
import 'package:problemator/models/problem_extra_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/widgets/problemator_action_button.dart';
import 'package:problemator/ui/theme/problemator_theme.dart';

const double _LIST_ITEM_HEIGHT = 40.0;

class BottomSheetAddTick extends StatefulWidget {
  final ProblemExtraInfo problemExtraInfo;
  final Problem problem;
  BottomSheetAddTick({this.problemExtraInfo, this.problem});

  @override
  State<StatefulWidget> createState() =>
      _BottomSheetAddTick(problemExtraInfo: this.problemExtraInfo, problem: problem);
}

class _BottomSheetAddTick extends State<BottomSheetAddTick> {
  final ProblemExtraInfo problemExtraInfo;
  final Problem problem;

  String _ascentType = 'send';
  int _amountOfTries = 1;
  int _gradeOpinion;
  DateTime _tickDate = DateTime.now();
  List<Grade> grades;
  int _selectedGradeIndex = 0;

  final TextEditingController _triesController = TextEditingController();

  _BottomSheetAddTick({this.problemExtraInfo, this.problem}) {
    if (this.problem != null) {
      _gradeOpinion = int.tryParse(this.problem.gradeid);
    }
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HashMap<String, Grade> _grades = context.select((HomeBloc bloc) => bloc.state.dashboard.grades);
    grades = _grades.values.toList()
      ..sort((a, b) => int.parse(a.score).compareTo(int.parse(b.score)));
    grades = _grades.values.toList()..sort((a, b) => int.parse(a.score) - int.parse(b.score));
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
                    onTap: () {
                      _openSelectTriesSheet(context);
                    },
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(_amountOfTries.toString() ?? "1",
                            style: TextStyle(fontSize: 24, color: theme.primaryColor)),
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
    String tickDateStr = DateFormat("yyyy-MM-dd").format(_tickDate);
    return Column(
      children: [
        ClipOval(
            child: Material(
                color: theme.colorScheme.roundButtonBackground,
                child: InkWell(
                    onTap: () {
                      _openSelectTickDateSheet(context);
                    },
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Icon(Icons.calculate_outlined),
                      )),
                    )))),
        Text(tickDateStr),
      ],
    );
  }

  Widget _buildGradeOpinionButton(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    String gradeStr =
        grades.firstWhere((curproblem) => _gradeOpinion == int.parse(curproblem.id)).font;
    return Column(
      children: [
        ClipOval(
            child: Material(
                color: theme.colorScheme.roundButtonBackground,
                child: InkWell(
                    onTap: () {
                      _openSelectGradeOpinionSheet(context);
                    },
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(gradeStr, style: textTheme.headline1),
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
            value: 'pretick',
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
        onPressed: () {
          // Call add tick
          final Tick tick =
              Tick(problemid: problem.id, tries: this._amountOfTries, ascentType: this._ascentType);
          context.read<ProblemBloc>().add(AddTick(tick: tick));
        },
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

  void _openSelectTriesSheet(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Text("How many tries did it take?", style: textTheme.headline5),
              Expanded(
                child: ListView.separated(
                  itemCount: 5,
                  itemBuilder: (ctx, idx) {
                    if (idx == 4) {
                      return ListTile(
                        title: TextField(
                          controller: _triesController,
                          onSubmitted: (val) {
                            setState(() {
                              _amountOfTries = int.tryParse(_triesController.text);
                            });
                            Navigator.pop(context);
                          },
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(hintText: "Enter custom amount of tries here"),
                        ),
                      );
                    } else {
                      return ListTile(
                        onTap: () {
                          setState(() {
                            _amountOfTries = idx + 1;
                          });
                          Navigator.pop(context);
                        },
                        title: Text((idx + 1).toString()),
                      );
                    }
                  },
                  separatorBuilder: (_, _sec) => Divider(),
                ),
              ),
            ]),
          );
        });
  }

  @override
  void dispose() {
    _triesController.dispose();
    super.dispose();
  }

  void _openSelectTickDateSheet(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Text("Select a tick date", style: textTheme.headline5),
              CalendarCarousel<Event>(
                onDayPressed: (DateTime date, List<Event> events) {
                  this.setState(() => _tickDate = date);
                  events.forEach((event) => print(event.title));
                  Navigator.pop(context);
                },
                weekendTextStyle: TextStyle(
                  color: Colors.red,
                ),
                thisMonthDayBorderColor: Colors.grey,
                //          weekDays: null, /// for pass null when you do not want to render weekDays
                headerText: 'Custom Header',
                weekFormat: true,
                //markedDatesMap: _markedDateMap,
                height: 200.0,
                selectedDateTime: _tickDate,
                showIconBehindDayText: true,
                //          daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
                customGridViewPhysics: NeverScrollableScrollPhysics(),
                markedDateShowIcon: true,
                markedDateIconMaxShown: 2,
                selectedDayTextStyle: TextStyle(
                  color: Colors.yellow,
                ),
                todayTextStyle: TextStyle(
                  color: Colors.blue,
                ),
                markedDateIconBuilder: (event) {
                  return event.icon;
                },
                minSelectedDate: _tickDate.subtract(Duration(days: 360)),
                maxSelectedDate: _tickDate.add(Duration(days: 360)),
                todayButtonColor: Colors.transparent,
                todayBorderColor: Colors.green,
                markedDateMoreShowTotal: true, // null for not showing hidden events indicator
                //          markedDateIconMargin: 9,
                //          markedDateIconOffset: 3,
              ),
            ]),
          );
        });
  }

  void _openSelectGradeOpinionSheet(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    ScrollController _scrollController = new ScrollController();
    // Fetch grades.
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Text("Select a grade opinion", style: textTheme.headline5),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: grades.length,
                    itemBuilder: (ctx, idx) {
                      bool isSelected = int.tryParse(grades[idx].id) == this._gradeOpinion;
                      return Container(
                        color: isSelected ? colorScheme.accentColor : null,
                        child: FlatButton(
                          height: _LIST_ITEM_HEIGHT,
                          onPressed: () => setState(() {
                            _gradeOpinion = int.tryParse(grades[idx].id);
                            Navigator.pop(context);
                          }),
                          child: Text(grades[idx].font),
                        ),
                      );
                    },
                  ),
                ),
              ]));
        });
    _selectedGradeIndex =
        grades.indexWhere((element) => this._gradeOpinion == int.parse(element.id));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(_selectedGradeIndex * (_LIST_ITEM_HEIGHT),
          duration: new Duration(milliseconds: 500), curve: Curves.ease);
    });
  }
}
