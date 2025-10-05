import 'package:dartz/dartz.dart';
import 'package:film_link/core/error/failures.dart';
import 'package:film_link/core/usecases/usecase.dart';
import 'package:film_link/features/auth/domain/repositories/auth_repository.dart';

/// Use case for signing out a user
class SignOut implements UseCase<void, NoParams> {
  final AuthRepository repository;
  
  SignOut(this.repository);
  
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.signOut();
  }
}
