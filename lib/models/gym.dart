import 'package:problemator/widgets/imagemap/image_map_shape.dart';

class Gym {
  final String id;
  final String name;
  final String country;
  final bool floorPlanExists;
  final String floorPlanURL;
  final List<ImageMapShape> shapes;

  Gym({this.id, this.name, this.country, this.floorPlanExists, this.floorPlanURL, this.shapes});

  static Gym fromJson(Map<String, dynamic> json) {
    return Gym(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      floorPlanURL: json['floorplan'],
      floorPlanExists: json['floorplanexists'],
      //shapes = json['floormap'];
    );
  }
}
