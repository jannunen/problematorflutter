/*import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:problemator/models/group.dart';

import 'group_event.dart';
import 'group_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final GroupsBloc _groupsBloc;

  //GroupsBloc({@required this.groupsRepository}) : super(GroupsLoadInProgress());

  @override
  Stream<GroupsState> mapEventToState(GroupsEvent event) async* {
    if (event is GroupsLoadSuccess) {
      yield* _mapGroupsLoadedToState(event);
    } else if (event is GroupAdded) {
      yield* _mapGroupAddedToState(event);
    } else if (event is GroupUpdated) {
      yield* _mapGroupUpdatedToState(event);
    } else if (event is GroupDeleted) {
      yield* _mapGroupDeletedToState(event);
    } else if (event is GetAllGroups) {
      yield* _mapGetAllGroupsToState();
    } 
  }

  @override
  Stream<GroupsState> _mapGroupsLoadedToState(GroupsEvent event) async* {
    if (state.status == GroupsStatus.loaded && event is GroupUpdated) {
      //yield* _mapGroupAddedToState(state, event);
    } else if (event is GroupUpdated) {
      yield (state.copyWith(
          groups: event.groups, status: GroupsStatus.loaded));
    } else if (event is ErrorLoadingProblems) {
      yield (state.copyWith(status: GroupsStatus.error, error: event.error));
    }
  }

  Stream<GroupsState> _mapGroupAddedToState(GroupAdded event) async* {
    if (state is GroupsLoadSuccess) {
      final List<Group> updatedGroups = List.from((state as GroupsLoadSuccess).groups)
        ..add(event.group);
      yield GroupsLoadSuccess(updatedGroups);
      _saveGroups(updatedGroups);
    }
  }

  Stream<GroupsState> _mapGroupUpdatedToState(GroupUpdated event) async* {
    if (state is GroupsLoadSuccess) {
      final List<Group> updatedGroups = (state as GroupsLoadSuccess).groups.map((group) {
        return group.id == event.updatedGroup.id ? event.updatedGroup : group;
      }).toList();
      yield GroupsLoadSuccess(updatedGroups);
      _saveGroups(updatedGroups);
    }
  }

  Stream<GroupsState> _mapGroupDeletedToState(GroupDeleted event) async* {
    if (state is GroupsLoadSuccess) {
      final updatedGroups = (state as GroupsLoadSuccess)
          .groups
          .where((group) => group.id != event.group.id)
          .toList();
      yield GroupsLoadSuccess(updatedGroups);
      _saveGroups(updatedGroups);
    }
  }

  Stream<GroupsState> _mapGetAllGroupsToState() async* {
    if (state is GroupsLoadSuccess) {
      final allComplete =
          (state as GroupsLoadSuccess).groups.every((group) => group.complete);
      final List<Group> updatedGroups = (state as GroupsLoadSuccess)
          .groups
          .map((group) => group.copyWith(complete: !allComplete))
          .toList();
      yield GroupsLoadSuccess(updatedGroups);
      _saveGroups(updatedGroups);
    }
  } 
}
*/