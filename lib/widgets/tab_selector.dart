import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          icon: _resolveIcon(context,tab),
          title: _resolveText(context,tab),
        );
      }).toList(),
    );
  }

    Icon _resolveIcon(BuildContext context, AppTab tab) {
      switch (tab) {
        case AppTab.home:
        return Icon(
          FontAwesomeIcons.home,
          key: ArchSampleKeys.homeTab
          );
          break;

          case AppTab.circuits:
        return Icon(
          FontAwesomeIcons.bicycle,
          key: ArchSampleKeys.circuitsTab
          );
          break;

          default:
          print("Missing icon");
          return Icon(FontAwesomeIcons.question);
          break;
      }
    }


    Text _resolveText(BuildContext context, AppTab tab) {
      switch (tab) {
        case AppTab.home:
          return Text(ArchSampleLocalizations.of(context).addProblem);
        break;

        default:
        print("Missing i18n for icon");
        return Text("Missing stuffsies");
        break;
      }

    }




}
