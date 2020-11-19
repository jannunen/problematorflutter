import 'package:equatable/equatable.dart';
import 'package:problemator/models/models.dart';

class Config extends Equatable {
  final User user;
  final String token;
  final bool darkMode;

  Config({this.user, this.token, this.darkMode});

  Config copyWith({user, token, darkMode}) => Config(
      user: user ?? this.user, token: token ?? this.token, darkMode: darkMode ?? this.darkMode);

  Map<String, dynamic> toJson() => {'user': user.toJson(), 'token': token, 'darkMode': darkMode};

  static Config fromJson(Map<String, dynamic> json) {
    return new Config(
        user: User.fromJson(json['user']), token: json['token'], darkMode: json['darkMode']);
  }

  @override
  // TODO: implement props
  List<Object> get props => [user, token, darkMode];
}
