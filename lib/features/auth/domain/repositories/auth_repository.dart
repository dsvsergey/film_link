import 'package:dartz/dartz.dart';
import 'package:film_link/core/error/failures.dart';
import 'package:film_link/features/auth/domain/entities/user_entity.dart';

/// Authentication repository interface
abstract class AuthRepository {
  /// Sign up with email and password
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
    String? displayName,
  });
  
  /// Sign in with email and password
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  });
  
  /// Sign in with Apple
  Future<Either<Failure, UserEntity>> signInWithApple();
  
  /// Sign in with Google
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  
  /// Sign out
  Future<Either<Failure, void>> signOut();
  
  /// Get current user
  Future<Either<Failure, UserEntity?>> getCurrentUser();
  
  /// Check if user is authenticated
  Future<Either<Failure, bool>> isAuthenticated();
  
  /// Reset password
  Future<Either<Failure, void>> resetPassword(String email);
}
