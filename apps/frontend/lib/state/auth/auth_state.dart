part of 'auth_bloc.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthStateInitial;

  const factory AuthState.loading() = AuthStateLoading;

  const factory AuthState.failure(Failure failure) = AuthStateFailure;

  const factory AuthState.success(AuthResponse data) = AuthStateSuccess;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}
