part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.loginRequested({
    required String email,
    required String password,
  }) = AuthLoginRequested;

  const factory AuthEvent.signUpRequested({
    required String email,
    required String password,
    required String name,
  }) = AuthSignUpRequested;

  const factory AuthEvent.logoutRequested() = AuthLogoutRequested;
  const factory AuthEvent.checkStatus() = AuthCheckStatus;
}