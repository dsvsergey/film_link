import 'package:dartz/dartz.dart';
import 'package:film_link/core/error/failures.dart';

/// Base class for all use cases
/// 
/// [Type] - return type
/// [Params] - parameters type
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Use case with no parameters
class NoParams {
  const NoParams();
}
