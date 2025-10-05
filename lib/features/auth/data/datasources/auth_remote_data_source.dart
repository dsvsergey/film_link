import 'package:film_link/core/error/exceptions.dart';
import 'package:film_link/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;

/// Remote data source for authentication
abstract class AuthRemoteDataSource {
  Future<UserModel> signUp({
    required String email,
    required String password,
    String? displayName,
  });

  Future<UserModel> signIn({required String email, required String password});

  Future<UserModel> signInWithApple();

  Future<UserModel> signInWithGoogle();

  Future<void> signOut();

  Future<UserModel?> getCurrentUser();

  Future<bool> isAuthenticated();

  Future<void> resetPassword(String email);
}

/// Implementation of AuthRemoteDataSource using Supabase
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: displayName != null ? {'display_name': displayName} : null,
      );

      if (response.user == null) {
        throw const AuthException('Sign up failed');
      }

      return _userToModel(response.user!);
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException('Sign up failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const AuthException('Sign in failed');
      }

      return _userToModel(response.user!);
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException('Sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signInWithApple() async {
    try {
      final response = await supabaseClient.auth.signInWithOAuth(
        OAuthProvider.apple,
      );

      if (!response) {
        throw const AuthException('Apple sign in failed');
      }

      final user = supabaseClient.auth.currentUser;
      if (user == null) {
        throw const AuthException('Apple sign in failed');
      }

      return _userToModel(user);
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException('Apple sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final response = await supabaseClient.auth.signInWithOAuth(
        OAuthProvider.google,
      );

      if (!response) {
        throw const AuthException('Google sign in failed');
      }

      final user = supabaseClient.auth.currentUser;
      if (user == null) {
        throw const AuthException('Google sign in failed');
      }

      return _userToModel(user);
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException('Google sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      throw AuthException('Sign out failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = supabaseClient.auth.currentUser;
      return user != null ? _userToModel(user) : null;
    } catch (e) {
      throw AuthException('Get current user failed: ${e.toString()}');
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      final session = supabaseClient.auth.currentSession;
      return session != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await supabaseClient.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw AuthException('Reset password failed: ${e.toString()}');
    }
  }

  /// Convert Supabase User to UserModel
  UserModel _userToModel(User user) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      displayName: user.userMetadata?['display_name'] as String?,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
      createdAt: DateTime.parse(user.createdAt),
    );
  }
}
