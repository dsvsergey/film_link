import 'package:film_link/core/usecases/usecase.dart';
import 'package:film_link/features/auth/domain/entities/user_entity.dart';
import 'package:film_link/features/auth/domain/usecases/sign_in.dart';
import 'package:film_link/features/auth/domain/usecases/sign_out.dart';
import 'package:film_link/features/auth/domain/usecases/sign_up.dart';
import 'package:film_link/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state_provider.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(UserEntity user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  final SignUp _signUp;
  final SignIn _signIn;
  final SignOut _signOut;

  AuthStateNotifier({
    required SignUp signUp,
    required SignIn signIn,
    required SignOut signOut,
  }) : _signUp = signUp,
       _signIn = signIn,
       _signOut = signOut,
       super(const AuthState.initial());

  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = const AuthState.loading();

    final result = await _signUp(
      SignUpParams(email: email, password: password, displayName: displayName),
    );

    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (user) => state = AuthState.authenticated(user),
    );
  }

  Future<void> signIn({required String email, required String password}) async {
    state = const AuthState.loading();

    final result = await _signIn(
      SignInParams(email: email, password: password),
    );

    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (user) => state = AuthState.authenticated(user),
    );
  }

  Future<void> signOut() async {
    state = const AuthState.loading();

    final result = await _signOut(const NoParams());

    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (_) => state = const AuthState.unauthenticated(),
    );
  }
}

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((
  ref,
) {
  return AuthStateNotifier(
    signUp: ref.watch(signUpUseCaseProvider),
    signIn: ref.watch(signInUseCaseProvider),
    signOut: ref.watch(signOutUseCaseProvider),
  );
});
