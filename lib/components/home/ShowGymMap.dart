import 'package:flutter/material.dart';

class ShowGymMap extends StatefulWidget {
  final Image floorPlan;

  ShowGymMap({this.floorPlan});

  _ShowGymMapState createState() => _ShowGymMapState();
}
  
class _ShowGymMapState extends State<ShowGymMap> {

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Image.network("https://www.problemator.fi/assets/images/floorplans/floorplan_11.png")
    ]);
  }
}