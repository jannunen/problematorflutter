
import 'package:problemator/models/group.dart';
import 'package:equatable/equatable.dart';

enum GroupsStatus { loading, loaded, error }

class GroupsState extends Equatable {
  final GroupsStatus status;
  final List<Group> groups;
  final String error;

  const GroupsState({
    this.status,
    this.groups,
    this.error,
  });

  @override
  List<Object> get props => [
        status,
        groups,
        error
      ];

  @override
  String toString() =>
      'GroupsLoaded {groups: $groups, status: $status, error: $error}';

  GroupsState copyWith({
    List<Group> groups,
    String error,
  }) {
    return GroupsState(
      groups: groups ?? this.groups,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
