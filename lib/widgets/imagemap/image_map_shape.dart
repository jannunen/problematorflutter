import 'package:poly/poly.dart';

import './image_map_coordinate.dart';

class ImageMapShape {
  final String title;
  final String description;
  final List<ImageMapCoordinate> points;

  ImageMapShape({this.title, this.description, this.points});

  translatePoints(List<Point> points, double width, double height) {
    return points.map((e) => Point(_scalePoint(e.x, width), _scalePoint(e.y, height))).toList();
  }

  double _scalePoint(double percentage, double realSize) {
    double div = (percentage / 100 * realSize);
    return div.roundToDouble();
  }
}
