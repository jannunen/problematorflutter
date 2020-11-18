import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:problemator/core/core.dart';
import 'package:problemator/models/models.dart';
import 'widgets.i18n.dart';

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
          icon: _resolveIcon(context, tab),
          label: _resolveText(context, tab),
        );
      }).toList(),
    );
  }

  Icon _resolveIcon(BuildContext context, AppTab tab) {
    switch (tab) {
      case AppTab.home:
        return Icon(FontAwesomeIcons.home, key: ArchSampleKeys.homeTab);
        break;

      case AppTab.circuits:
        return Icon(FontAwesomeIcons.bicycle, key: ArchSampleKeys.circuitsTab);
        break;

      case AppTab.groups:
        return Icon(FontAwesomeIcons.userFriends, key: ArchSampleKeys.circuitsTab);
        break;

      case AppTab.profile:
        return Icon(FontAwesomeIcons.user, key: ArchSampleKeys.circuitsTab);
        break;

      case AppTab.archive:
        return Icon(FontAwesomeIcons.archive, key: ArchSampleKeys.circuitsTab);
        break;

      case AppTab.competitions:
        return Icon(FontAwesomeIcons.trophy, key: ArchSampleKeys.competitionsTab);
        break;

      default:
        print("Missing icon " + tab.toString());
        return Icon(FontAwesomeIcons.question);
        break;
    }
  }

  String _resolveText(BuildContext context, AppTab tab) {
    switch (tab) {
      case AppTab.home:
        return "Home".i18n;
        break;
      case AppTab.profile:
        return "Profile".i18n;
        break;
      case AppTab.circuits:
        return "Circuits".i18n;
        break;
      case AppTab.groups:
        return "Groups".i18n;
        break;
      case AppTab.archive:
        return "Archive".i18n;
        break;
      case AppTab.competitions:
        return "Competitions".i18n;
        break;

      default:
        print("Missing i18n for icon " + tab.toString());
        return ("Missing stuffsies");
        break;
    }
  }
}
