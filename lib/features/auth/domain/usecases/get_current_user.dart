import 'package:dartz/dartz.dart';
import 'package:film_link/core/error/failures.dart';
import 'package:film_link/core/usecases/usecase.dart';
import 'package:film_link/features/auth/domain/entities/user_entity.dart';
import 'package:film_link/features/auth/domain/repositories/auth_repository.dart';

/// Use case for getting current user
class GetCurrentUser implements UseCase<UserEntity?, NoParams> {
  final AuthRepository repository;
  
  GetCurrentUser(this.repository);
  
  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
