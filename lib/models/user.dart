import 'package:equatable/equatable.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    this.email,
    this.id,
    this.name,
    this.photo,
    this.uid,
    this.jwt,
    this.gymid,
    this.message,
  });

  /// The current user's email address.
  final String email;

  /// The current user's id.
  final String id;
  final String uid;
  final String jwt;
  final String message;
  final String gymid;

  /// The current user's name (display name).
  final String name;

  /// Url for the current user's photo.
  final String photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(email: '', id: '', name: null, photo: null, gymid: null);

  @override
  List<Object> get props => [email, id, name, photo, gymid];

  static User fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] ?? null,
      uid: json['uid'] ?? null,
      id: json['uid'] ?? null,
      message: json['message'] ?? null,
      jwt: json['JWT'] ?? null,
      gymid: json['gymid'] ?? null,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'id': id,
      'uid': uid,
      'message': message,
      'JWT': jwt,
      'gymid': gymid,
    };
  }
}
