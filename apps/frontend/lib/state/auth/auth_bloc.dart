import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend/api/export.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/shared/either.dart';
import 'package:frontend/shared/failure.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_bloc.freezed.dart';

part 'auth_bloc.g.dart';

part 'auth_event.dart';

part 'auth_state.dart';

typedef _AuthAction<T> = Future<Either<Failure, AuthResponse>> Function();

@singleton
final class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(const AuthState.initial()) {
    on<AuthEventSignup>(_signup);
    on<AuthEventSignin>(_signin);
    on<AuthEventRefresh>(_refresh);
  }

  Future<void> _signup(AuthEventSignup event, Emitter<AuthState> emit) async {
    await _performAuthAction(() => _authService.signup(event.data), emit);
  }

  Future<void> _signin(AuthEventSignin event, Emitter<AuthState> emit) async {
    await _performAuthAction(() => _authService.signin(event.data), emit);
  }

  Future<void> _refresh(AuthEventRefresh event, Emitter<AuthState> emit) async {
    await _performAuthAction(() => _authService.refresh(event.data), emit);
  }

  Future<void> _performAuthAction(
    _AuthAction action,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await action();
    emit(
      switch (result) {
        Left(value: final f) => AuthState.failure(f),
        Right(value: final s) => AuthState.success(s),
      },
    );
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return switch (state) {
      AuthStateSuccess() => state.toJson(),
      _ => null,
    };
  }
}

extension DIAuthBloc on GetIt {
  AuthBloc get authBloc => this();
}
