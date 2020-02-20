import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ShowGymMap extends StatefulWidget {
  final Image floorPlan;

  ShowGymMap({this.floorPlan});

  _ShowGymMapState createState() => _ShowGymMapState();
}
  
class _ShowGymMapState extends State<ShowGymMap> {

  @override
  Widget build(BuildContext context) {
    return Container(child: new PhotoView(
        imageProvider: NetworkImage("https://www.problemator.fi/assets/images/floorplans/floorplan_11.png"),
        minScale: PhotoViewComputedScale.contained * 0.9,
        maxScale: PhotoViewComputedScale.covered * 1.8,
        initialScale: PhotoViewComputedScale.contained * 0.9,
        basePosition: Alignment.center,
      )
      
 );
  }
}