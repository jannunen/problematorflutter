import 'package:problemator/models/user.dart';
import 'package:equatable/equatable.dart';

class Group extends Equatable {
  final String id;
  final String name;
  final String description;
  final bool messaging;
  final bool visibility;
  final List<User> groupMembers;

  Group({this.id, this.name, this.description, this.messaging, this.visibility, this.groupMembers});

  static Group fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      messaging: json['messaging'],
      visibility: json['visibility'],
      groupMembers: json['groupMembers']
    );
  }

  @override
  List<Object> get props => [id, name, description, messaging, visibility];

  Group copyWith({
    id,
    name,
    description,
    messaging,
    visibility,
    groupMembers
  }) {
    return Group(
      id: id,
      name: name,
      description: description,
      messaging: messaging,
      visibility: visibility,
      groupMembers: groupMembers
    );
  }
}