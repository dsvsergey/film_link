import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:film_link/core/error/failures.dart';
import 'package:film_link/core/usecases/usecase.dart';
import 'package:film_link/features/auth/domain/entities/user_entity.dart';
import 'package:film_link/features/auth/domain/repositories/auth_repository.dart';

/// Use case for signing up a new user
class SignUp implements UseCase<UserEntity, SignUpParams> {
  final AuthRepository repository;
  
  SignUp(this.repository);
  
  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async {
    return await repository.signUp(
      email: params.email,
      password: params.password,
      displayName: params.displayName,
    );
  }
}

class SignUpParams extends Equatable {
  final String email;
  final String password;
  final String? displayName;
  
  const SignUpParams({
    required this.email,
    required this.password,
    this.displayName,
  });
  
  @override
  List<Object?> get props => [email, password, displayName];
}
