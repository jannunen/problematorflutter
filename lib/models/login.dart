import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final String email;
  final String uid;
  final String message;
  final String jwt;

  Login({this.email, this.uid, this.message, this.jwt});

  @override
  List<Object> get props => ['email', 'uid', 'message', 'jwt'];

  static Login fromJson(Map<String, dynamic> json) {
    return Login(
      email: json['email'] ?? null,
      uid: json['uid'] ?? null,
      message: json['message'] ?? null,
      jwt: json['jwt'] ?? null,
    );
  }
}
