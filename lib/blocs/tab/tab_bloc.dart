import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:problemator/blocs/tab/tab.dart';
import 'package:problemator/models/models.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.home;

  @override
  Stream<AppTab> mapEventToState( TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }

  
}