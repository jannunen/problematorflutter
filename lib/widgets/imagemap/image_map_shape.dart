import 'package:poly/poly.dart';

import './image_map_coordinate.dart';

class ImageMapShape {
  final String title;
  final String description;
  final int id;
  final List<ImageMapCoordinate> points;

  ImageMapShape({this.title, this.description, this.points, this.id});

  translatePoints(List<Point> points, double width, double height) {
    return points.map((e) => Point(_scalePoint(e.x, width), _scalePoint(e.y, height))).toList();
  }

  double _scalePoint(double percentage, double realSize) {
    double div = (percentage / 100 * realSize);
    return div.roundToDouble();
  }

  static ImageMapShape fromJson(id, json) {
    return ImageMapShape(
      description: json['description'],
      id: id,
      title: json['title'],
      points: pointsFromJson(json['points']),
    );
  }

  static pointsFromJson(json) {
    List<ImageMapCoordinate> points = [];
    if (json != null) {
      json.forEach((value) {
        if (value != null) {
          points.add(ImageMapCoordinate.fromJson(value));
        }
      });
      return points;
    }
  }
}
