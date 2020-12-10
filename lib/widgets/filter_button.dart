import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/core/core.dart';
import 'package:problemator/blocs/filtered_problems/filtered_problems.dart';
import 'package:problemator/models/models.dart';

import "widgets.i18n.dart";

class FilterButton extends StatelessWidget {
  final bool visible;

  FilterButton({this.visible, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.body1;
    final activeStyle =
        Theme.of(context).textTheme.body1.copyWith(color: Theme.of(context).accentColor);
    return BlocBuilder<FilteredProblemsBloc, FilteredProblemsState>(builder: (context, state) {
      final button = _Button(
        onSelected: (filter) {
          //BlocProvider.of<FilteredProblemsBloc>(context).add(UpdateFilter(selectedWalls : wallids));
        },
        activeFilter: state is FilteredProblemsLoaded ? state.activeFilter : VisibilityFilter.all,
        activeStyle: activeStyle,
        defaultStyle: defaultStyle,
      );
      return AnimatedOpacity(
        opacity: visible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 150),
        child: visible ? button : IgnorePointer(child: button),
      );
    });
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key key,
    @required this.onSelected,
    @required this.activeFilter,
    @required this.activeStyle,
    @required this.defaultStyle,
  }) : super(key: key);

  final PopupMenuItemSelected<VisibilityFilter> onSelected;
  final VisibilityFilter activeFilter;
  final TextStyle activeStyle;
  final TextStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityFilter>(
      key: ArchSampleKeys.filterButton,
      tooltip: "Filter problems".i18n,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuItem<VisibilityFilter>>[
        PopupMenuItem<VisibilityFilter>(
          key: ArchSampleKeys.allFilter,
          value: VisibilityFilter.all,
          child: Text(
            ArchSampleLocalizations.of(context).showAll,
            style: activeFilter == VisibilityFilter.all ? activeStyle : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          key: ArchSampleKeys.activeFilter,
          value: VisibilityFilter.climbed,
          child: Text(
            ArchSampleLocalizations.of(context).showActive,
            style: activeFilter == VisibilityFilter.climbed ? activeStyle : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          key: ArchSampleKeys.completedFilter,
          value: VisibilityFilter.project,
          child: Text(
            ArchSampleLocalizations.of(context).showCompleted,
            style: activeFilter == VisibilityFilter.project ? activeStyle : defaultStyle,
          ),
        ),
      ],
      icon: Icon(Icons.filter_list),
    );
  }
}
