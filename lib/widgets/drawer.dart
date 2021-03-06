import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/tab/tab.dart';
import '../models/app_tab.dart';

class DrawerMenu extends StatelessWidget {
  final List<_NavigationItem> _listItems = [
    _NavigationItem(true, null, null, null),
    _NavigationItem(false, AppTab.home, "Home", Icons.looks_one),
    _NavigationItem(false, AppTab.profile, "Profile", Icons.looks_two),
    _NavigationItem(false, AppTab.archive, "Archive", Icons.looks_3),
    _NavigationItem(false, AppTab.circuits, "Circuits", Icons.looks_4),
    _NavigationItem(false, AppTab.groups, "Groups", Icons.looks_5),
    _NavigationItem(false, AppTab.logout, "Logout", Icons.looks_6),
  ];

  Widget build(BuildContext context) => Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
        //color: Theme.of(context).backgroundColor,
        //child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          padding: EdgeInsets.zero,
          children: [
            ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: _listItems.length,
                itemBuilder: (BuildContext context, int index) => BlocBuilder<TabBloc, AppTab>(
                      builder: (BuildContext context, AppTab tab) { 
                      return  _buildItem(context, _listItems[index], tab);
                      }
                    )),
          ],
        ),
      //)
      );
}

Widget _buildItem(BuildContext context, _NavigationItem data, AppTab tab) => data.header
     // if the item is a header return the header widget
    ? _makeHeaderItem()
    // otherwise build and return the default list item
    : _makeListItem(context, data, tab);

Widget _makeHeaderItem() => UserAccountsDrawerHeader(
      accountName: Text("accname", style: TextStyle(color: Colors.white)),
      accountEmail: Text("accemail", style: TextStyle(color: Colors.white)),
      decoration: BoxDecoration(color: Colors.blueGrey),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.amber,
        child: Icon(
          Icons.person,
          size: 54,
        ),
      ),
    );

Widget _makeListItem(BuildContext context, _NavigationItem data, AppTab tab) => Card(
      color:
          data.item == tab ? Theme.of(context).selectedRowColor : Theme.of(context).backgroundColor,
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
      // So we see the selected highlight
      borderOnForeground: true,
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Builder(
        builder: (BuildContext context) => ListTile(
          title: Text(
            data.title,
            style: TextStyle(
              color: data.item == tab ? Colors.blue : Colors.blueGrey,
            ),
          ),
          leading: Icon(
            data.icon,
            // if it's selected change the color
            color: data.item == tab ? Colors.blue : Colors.blueGrey,
          ),
          onTap: () => _handleItemClick(context, data.item),
        ),
      ),
    );

void _handleItemClick(BuildContext context, AppTab item) {
  print("Passing item " + item.toString());

  if (AppTab.logout == item) {
    // Just logout.
    /*
    final AuthenticationRepository authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
    authenticationRepository.logOut();
    */
  } else {
    BlocProvider.of<TabBloc>(context).add(UpdateTab(item));
  }
  Navigator.pop(context);
}

class _NavigationItem {
  final bool header;
  final AppTab item;
  final String title;
  final IconData icon;
  _NavigationItem(this.header, this.item, this.title, this.icon);
}
