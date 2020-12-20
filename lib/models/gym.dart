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

  static List<Gym> listFromJson(Map<String, dynamic> json) {
    List<Gym> gymlist = List();
    if (json != null) {
      json.forEach((key, value) {
        gymlist.add(Gym.fromJson(value));
      });
    }
    return gymlist;
  }

  Map<String, dynamic> toJson() => toMap();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'country': country,
    };
  }
}
