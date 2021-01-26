import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:problemator/models/models.dart';
import 'package:problemator/repository/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository)
      : assert(_authenticationRepository != null),
        super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      try {
        await _authenticationRepository.logInWithEmailAndPassword(
          email: state.email.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on LogInWithEmailAndPasswordFailure catch (err) {
        emit(state.copyWith(status: FormzStatus.submissionFailure, message: err.message));
      } on Exception catch (err) {
        emit(state.copyWith(status: FormzStatus.submissionFailure, message: err.toString()));
      }
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    } on NoSuchMethodError {
      emit(state.copyWith(status: FormzStatus.pure));
    }
  }
}
