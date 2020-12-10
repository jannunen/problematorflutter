import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:problemator/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, User> {
  UserBloc() : super(null);

  @override
  Stream<User> mapEventToState(
    UserEvent event,
  ) async* {
    yield (event.user);
  }
}
