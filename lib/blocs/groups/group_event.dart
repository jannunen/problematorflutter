/*import 'package:equatable/equatable.dart';
import 'package:problemator/models/group.dart';

abstract class GroupsEvent extends Equatable {
  const GroupsEvent();

  @override
  List<Object> get props => [];
}

class GroupsLoadSuccess extends GroupsEvent {}

class GroupAdded extends GroupsEvent {
  final Group group;

  const GroupAdded(this.group);

  @override
  List<Object> get props => [group];

  @override
  String toString() => 'GroupAdded { group: $group}';
}

class GroupUpdated extends GroupsEvent {
  final Group group;

  const GroupUpdated(this.group);

  @override
  List<Object> get props => [group];

  @override
  String toString() => 'GroupUpdated { group: $group }';
}

class GroupDeleted extends GroupsEvent {
  final Group group;

  const GroupDeleted(this.group);

  @override
  List<Object> get props => [group];

  @override
  String toString() => 'GroupDeleted { group: $group }';
}

class GetAllGroups extends GroupsEvent {}

class ErrorLoadingGroups extends GroupsEvent {
  String error;
  ErrorLoadingGroups(this.error);

  @override
  List<Object> get props => [error];
} */