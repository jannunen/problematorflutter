import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:problemator/core/core.dart';
import 'package:problemator/models/models.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: ArchSampleKeys.tabs,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab == AppTab.home ? Icons.list : Icons.show_chart,
            key: tab == AppTab.home
                ? ArchSampleKeys.problemTab
                : ArchSampleKeys.statsTab,
          ),
          title: Text(tab == AppTab.stats
              ? ArchSampleLocalizations.of(context).stats
              : ArchSampleLocalizations.of(context).problems),
        );
      }).toList(),
    );
  }
}
