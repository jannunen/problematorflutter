import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/rendering.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Home", debugShowCheckedModeBanner: false, home: HomePageWidget());
  }
}

class HomePageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        //_buildCoverImage(screenSize),
        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTodayArea(),
              ],
            ),
          ),
        )
      ],
    ));
  }

  Widget _buildTodayArea() => Center(
          child: Column(children: [
        Text("Username's logs"),
        Text("Today"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [Text("1"), Text("Route(s)")],
            ),
            RaisedButton(child: Text("+ Add"), onPressed: null),
          ],
        ),
      ]));
}
