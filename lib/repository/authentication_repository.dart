import 'dart:async';

import 'package:problemator/api/api_client.dart';
import 'package:problemator/blocs/user/bloc/user_bloc.dart';
import 'package:problemator/models/models.dart';
import 'package:meta/meta.dart';
import 'package:problemator/repository/user_repository.dart';

/// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {}

/// Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {
  final String message;
  LogInWithEmailAndPasswordFailure(this.message);
}

/// Thrown during the sign in with google process if a failure occurs.

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    ApiClient apiClient,
    UserBloc userBloc,
  })  :
        _apiClient = apiClient ?? ApiClient(),
        _userBloc = userBloc {}

  final ApiClient _apiClient;
  UserBloc _userBloc;

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpFailure] if an exception occurs.
  Future<void> signUp({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {

    } on Exception {
      throw SignUpFailure();
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      final User user = await _apiClient.login(email, password);
      _userBloc.add(UserEvent(user));
    } on LogInWithEmailAndPasswordFailure catch (err) {
      throw LogInWithEmailAndPasswordFailure(err.message ?? '');
    } on Exception catch (err) {
      throw LogInWithEmailAndPasswordFailure(err.toString());
    }
  }

  void setUserBloc(UserBloc bloc) {
    this._userBloc = bloc;
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _apiClient.logout(),
      ]);
      _userBloc.add(UserEvent(User.empty));
    } on Exception {
      throw LogOutFailure();
    }
  }
}
