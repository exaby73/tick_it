part of 'auth_bloc.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.signup(SignupRequest data) = AuthEventSignup;

  const factory AuthEvent.signin(SigninRequest data) = AuthEventSignin;
  
  const factory AuthEvent.refresh(RefreshRequest data) = AuthEventRefresh;
}
