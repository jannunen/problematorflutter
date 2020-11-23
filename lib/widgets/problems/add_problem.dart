import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:problemator/blocs/home/bloc/home_bloc.dart';
import 'package:problemator/ui/theme/problemator_theme.dart';
import 'package:problemator/core/screen_helpers.dart';
import 'package:problemator/ui/theme/problemator_theme.dart';
import 'package:problemator/models/problem.dart';
import 'package:problemator/widgets/problemator_button.dart';
import 'package:problemator/widgets/problems/problem_color_indicator.dart';
import 'package:problemator/widgets/problems/show_problem.dart';

class AddProblemForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddProblemForm();
}

class _AddProblemForm extends State<AddProblemForm> {
  Problem selected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Container(
        height: displayHeight(context) * 0.8,
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
                      child: _buildAutocompleteTextField(context),
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

  Widget _buildAutocompleteTextField(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<Problem>>();
    // Build suggestion
    final suggestionsRaw = context.select((HomeBloc b) => b.state.dashboard.problems);
    List<Problem> suggestions = new List<Problem>();
    suggestionsRaw.forEach((item) => suggestions.add(item));

    return AutoCompleteTextField<Problem>(
      decoration:
          new InputDecoration(hintText: "Search problem:", suffixIcon: new Icon(Icons.search)),
      itemSubmitted: (item) {
        //Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (dialogContext) {
            return BlocProvider.value(
                value: BlocProvider.of<HomeBloc>(context), child: ShowProblem(id: item.id));
          }),
        );

/*
        setState(() {
          selected = item;
        });
        */
      },
      key: key,
      suggestions: suggestions,
      itemBuilder: (context, suggestion) => _buildSearchResultItem(context, suggestion),
      itemSorter: (a, b) => a.cLike == b.cLike
          ? 0
          : a.cLike > b.cLike
              ? -1
              : 1,
      itemFilter: (suggestion, input) =>
          suggestion.tagshort.toLowerCase().contains(input.toLowerCase()),
    );
  }

  void _openQRCodeScanner() {
    // noip for now
  }

  _openFloorPlanSelector() {}

  _buildSearchResultItem(BuildContext context, Problem suggestion) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    return new Padding(
        child: new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: ProblemColorIndicator(
                  htmlcolour: suggestion.htmlcolour,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Text(suggestion.tagshort),
            ],
          ),
          Text(suggestion.gradename, style: textTheme.headline6),
          Text(suggestion.walldesc),
        ]),
        padding: EdgeInsets.all(8.0));
  }
}
