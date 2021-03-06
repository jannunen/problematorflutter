import 'package:equatable/equatable.dart';

class Wall extends Equatable {
  final String id;
  final String wallchar;
  final String walldesc;

  Wall(this.id, this.wallchar, this.walldesc);

  @override
  List<Object> get props => [id, wallchar, walldesc];

  static Wall fromJson(Map<String, dynamic> json) {
    return Wall(json["id"], json["wallchar"], json["walldesc"]);
  }
}
