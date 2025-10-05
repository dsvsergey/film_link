import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:film_link/core/error/failures.dart';
import 'package:film_link/core/usecases/usecase.dart';
import 'package:film_link/features/auth/domain/entities/user_entity.dart';
import 'package:film_link/features/auth/domain/repositories/auth_repository.dart';

/// Use case for signing in a user
class SignIn implements UseCase<UserEntity, SignInParams> {
  final AuthRepository repository;
  
  SignIn(this.repository);
  
  @override
  Future<Either<Failure, UserEntity>> call(SignInParams params) async {
    return await repository.signIn(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInParams extends Equatable {
  final String email;
  final String password;
  
  const SignInParams({
    required this.email,
    required this.password,
  });
  
  @override
  List<Object?> get props => [email, password];
}
