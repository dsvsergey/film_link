import 'package:dartz/dartz.dart';
import 'package:film_link/core/error/failures.dart';
import 'package:film_link/core/usecases/usecase.dart';
import 'package:film_link/features/links/domain/entities/directory_entity.dart';
import 'package:film_link/features/links/domain/repositories/links_repository.dart';

class CreateDirectory implements UseCase<DirectoryEntity, DirectoryEntity> {
  final LinksRepository repository;

  CreateDirectory(this.repository);

  @override
  Future<Either<Failure, DirectoryEntity>> call(DirectoryEntity params) async {
    return await repository.createDirectory(directory: params);
  }
}
