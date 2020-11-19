part of 'user_bloc.dart';

class UserEvent extends User {
  final User user;
  const UserEvent(this.user);

  @override
  List<Object> get props => [user];
}
