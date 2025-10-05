import 'package:dartz/dartz.dart';
import 'package:film_link/core/error/failures.dart';
import 'package:film_link/core/usecases/usecase.dart';
import 'package:film_link/features/links/domain/entities/directory_entity.dart';
import 'package:film_link/features/links/domain/repositories/links_repository.dart';

class GetDirectoriesByUserId
    implements UseCase<List<DirectoryEntity>, NoParams> {
  final LinksRepository repository;

  GetDirectoriesByUserId(this.repository);

  @override
  Future<Either<Failure, List<DirectoryEntity>>> call(NoParams params) async {
    return await repository.getDirectoriesByUserId();
  }
}
