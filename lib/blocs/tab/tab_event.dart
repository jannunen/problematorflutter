import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:problemator/models/models.dart';

@immutable
abstract class TabEvent extends Equatable {
  TabEvent([List props = const []]) : super();
}

class UpdateTab extends TabEvent {
  final AppTab tab;

  UpdateTab(this.tab);

  @override
  String toString() => 'UpdateTab { tab: $tab }';

  @override
  List<Object> get props => [tab];
  
}
