import 'package:flutter/material.dart';
//import 'package:problemator/components/ImageMap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:i18n_extension/i18n_widget.dart";
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:problemator/components/FancyFab.dart';
import 'package:problemator/components/home/ShowGymMap.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'store/reducer.dart';

void main() {
  final Store<int> store = Store<int>(reducer, initialState: 0);
  runApp(Problemator(store));
}

class Problemator extends StatelessWidget {
  static const String _title = 'Problemator';

  final Store<int> store; 
  Problemator(this.store);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store : store,
      child : MaterialApp(
      localizationsDelegates: [            
               GlobalMaterialLocalizations.delegate,
               GlobalWidgetsLocalizations.delegate,
               GlobalCupertinoLocalizations.delegate,
            ],
             supportedLocales: [
               const Locale('en', "US"), 
               const Locale('fi', "FI"), 
            ],
        title : _title,
        home : I18n(
          initialLocale : Locale('fi'),
          child : ProblematorWidget()
          ),
    ));
  }
}

class ProblematorWidget extends StatefulWidget {
  ProblematorWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProblematorWidget createState() => _ProblematorWidget();
}

class _ProblematorWidget extends State<ProblematorWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePageWidget(title : 'Home'),
    Text(
      "My profile",
      style:optionStyle,
    ),
    Text(
      'Circuits',
      style: optionStyle,
    ),
    Text(
      'Groups',
      style: optionStyle,
    ),
    Text(
      'Training calendar',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Problemator'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.home),
            title: Text('Problems'),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            title: Text('My Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.bicycle),
            title: Text('Circuits'),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userFriends),
            title: Text('Groups'),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.calendarAlt),
            title: Text('History'),
          ),
        ],
        type : BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

}


class HomePageWidget extends StatelessWidget {
  const HomePageWidget({
    this.title
  });
  final String title;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: Center(
        child: ShowGymMap(),
      ),
      floatingActionButton: FancyFab(
        onPressed: () {
          // Add your onPressed code here!
        },
      ),
    );
  }

}